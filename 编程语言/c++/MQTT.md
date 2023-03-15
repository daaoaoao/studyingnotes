```
#pragma once
#include "ToolDefine.h"
#include "CommCnc.h"
#include <MQTTClient.h>
#include "DataDefine.h"
#include "ServerLog.h"
#include "CommandTaskQueue.h"
#include "Semaphore.h"
#include <deque>
class MQTTSub
{
public:
	MQTTSub();
	~MQTTSub();
	
	//设置ip地址和端口
	void SetIpPort(const IpPort& data);

	//初始化MQTT数据
	bool InitMQTTData(const ConfigData& data);

	//建立订阅连接
	bool SubConnection();

	//连接断开时的回调
	void OnConnect(void* context, char* cause);

	//当客户端从代理接收到消息时的回调
	void MessageProcessingCallbacks(void* context, char* topicName, int topicLen, MQTTClient_message* message);

	//发送成功的回调
	void OnDeliveryComplete(void* context, MQTTClient_deliveryToken token);

	//订阅指定Topic信息
	bool SubscribeTopic(const std::string& topic);

private:
	//清空任务队列
	void ClearTask(const std::string& data, int iType);
	//运行线程
	void Run();

private:
	//是否停止
	bool bStop_;
	//ip地址
	std::string strIp_;
	//端口
	int iPort_;
	//用户名
	std::string strUserName_;
	//密码
	std::string strPassword_;
	//客户端id
	std::string strClientId_;
	//主题
	std::string strTopic_;
	//MQTT客户端
	MQTTClient mqttClient_;
	
	//任务队列 可能思路就是任务队列或者向本地端口进行转发
	std::shared_ptr<CommandTaskQueue> taskQueue_;
	
	std::shared_ptr<std::thread> runThread_;  //运行线程

	std::shared_ptr<TcpClient> tcpClient_;//Tcp客户端
	
	std::shared_ptr<Semaphore> sema_; //信号量
	
	//数据队列
	std::deque<std::string> dataQueue_;
};


```

```
#include "MQTTSub.h"
#include "TcpClient.h"
#include "ServerLog.h"
MQTTSub::MQTTSub():bStop_(false),mqttClient_(NULL)
{
	/*taskQueue_ = std::shared_ptr<CommandTaskQueue>(new CommandTaskQueue(std::bind(&MQTTSub::ClearTask, this, std::placeholders::_1, std::placeholders::_2)));*/
	sema_ = std::shared_ptr<Semaphore>(new Semaphore(1));
	tcpClient_ = std::shared_ptr<TcpClient>(new TcpClient);
	runThread_ = std::shared_ptr<std::thread>(new std::thread(&MQTTSub::Run, this));
	
}

MQTTSub::~MQTTSub()
{
}

void MQTTSub::SetIpPort(const IpPort& data)
{
	
}

bool MQTTSub::InitMQTTData(const ConfigData& data)
{
	strUserName_ = data.mqttData.strUserName;
	strPassword_ = data.mqttData.strPassWord;
	strClientId_ = data.mqttData.strClientId;
	strTopic_ = data.mqttData.strTopic;
	strIp_ = data.mqttData.mqttIpPort.strIp;
	iPort_ = data.mqttData.mqttIpPort.iPort;
	return	true;
}

bool MQTTSub::SubConnection()
{
	MQTTClient_connectOptions conn_opts = MQTTClient_connectOptions_initializer;
	MQTTClient_message pubmsg = MQTTClient_message_initializer;
	MQTTClient_deliveryToken token = NULL;
	int rc = 0;
	
	//创建MQTT客户端
	rc = MQTTClient_create(&mqttClient_, strIp_.c_str(), strClientId_.c_str(), MQTTCLIENT_PERSISTENCE_NONE, NULL);
	if (rc != MQTTCLIENT_SUCCESS)
	{
		WriteErrorLog("创建MQTT链接失败");
		return false;
	}
	conn_opts.keepAliveInterval = 20;
	conn_opts.cleansession = 1;
	conn_opts.username = strUserName_.c_str();
	conn_opts.password = strPassword_.c_str();
	
	//设置回调
	if ((rc = MQTTClient_setCallbacks(mqttClient_, NULL, OnConnect, MessageProcessingCallbacks, OnDeliveryComplete)) != MQTTCLIENT_SUCCESS)
	{
		WriteErrorLog("连接失败, return code %d\n", rc);
		exit(EXIT_FAILURE);
	}
	
	
	
	return true;
}

void MQTTSub::OnConnect(void* context, char* cause)
{
}

void MQTTSub::ClearTask(const std::string& data, int iType)
{
}

void MQTTSub::MessageProcessingCallbacks(void* context, char* topicName, int topicLen, MQTTClient_message* message)
{
	nlohmann::json commandDataJson((char*)message->payload);
	std::string commandDataString = commandDataJson.dump();
	//添加到数据队列
	sema_->Acquire();
	dataQueue_.push_back(commandDataString);
	sema_->Release();
}

void MQTTSub::OnDeliveryComplete(void* context, MQTTClient_deliveryToken token)
{
}

bool MQTTSub::SubscribeTopic(const std::string& topic)
{
	return false;
}

```



```
#include "MQTTSub.h"
#include "TcpClient.h"
#include "ServerLog.h"

std::deque<std::string> MQTTSub::dataQueue_;
std::shared_ptr<Semaphore>  MQTTSub::sema_ = std::shared_ptr<Semaphore>(new Semaphore(1));

MQTTSub::MQTTSub():bStop_(false)
{
	/*taskQueue_ = std::shared_ptr<CommandTaskQueue>(new CommandTaskQueue(std::bind(&MQTTSub::ClearTask, this, std::placeholders::_1, std::placeholders::_2)));*/
	
	tcpClient_ = std::shared_ptr<TcpClient>(new TcpClient);
	subThread_ = std::shared_ptr<std::thread>(new std::thread(&MQTTSub::SubThread, this));
}

MQTTSub::~MQTTSub()
{
}


bool MQTTSub::InitMQTTData(const ConfigData& data)
{
	strUserName_ = data.mqttData.strUserName;
	strPassword_ = data.mqttData.strPassWord;
	strClientId_ = data.mqttData.strClientId;
	strTopic_ = data.mqttData.strTopic;
	strIp_ = data.mqttData.mqttIpPort.strIp;
	iPort_ = data.mqttData.mqttIpPort.iPort;
	return	true;
}

void MQTTSub::OnConnect(void* context, MQTTAsync_successData* response)
{
	if(!mqttServer.connected)
	{
		mqttServer.connected = true;
	}
	//连接成功后订阅主题，但是只会在第一次连接成功后调用，后续的自动重连并不会订阅调用
	MQTTAsync client = (MQTTAsync)context;
	MQTTAsync_responseOptions ropts = MQTTAsync_responseOptions_initializer;
	ropts.onSuccess = mqttServer.onSubcribe;
	
	int rc = 0;
	if ((rc = MQTTAsync_subscribe(client, mqttServer.topic.c_str(), mqttServer.qos, &ropts)) != MQTTASYNC_SUCCESS)
	{
		WriteErrorLog("订阅失败");
	}
}

void MQTTSub::OnConnectFailure(void* context, MQTTAsync_failureData* response)
{
	if (mqttServer.connected)
		mqttServer.connected = 0;
	WriteErrorLog(pstringArg("连接失败 {}", response ? response->code : -1));
	MQTTAsync client = (MQTTAsync)context;
}

void MQTTSub::OnDisconnect(void* context, MQTTAsync_successData* response)
{
	if (mqttServer.connected)
		mqttServer.connected = 0;
	WriteErrorLog("断开连接");
}

void MQTTSub::OnConnectionLost(void* context, char* cause)
{
	if (mqttServer.connected)
		mqttServer.connected = 0;
	WriteErrorLog(pstringArg("连接丢失 {}", cause));
}


void MQTTSub::ClearTask(const std::string& data, int iType)
{
}

//当客户端从代理接收到消息时的回调
int MessageProcessingCallbacks(void* context, char* topicName, int topicLen, MQTTAsync_message* message)
{
	nlohmann::json commandDataJson((char*)message->payload);
	std::string commandDataString = commandDataJson.dump();
	//添加到数据队列
	sema_->Acquire();
	MQTTSub::dataQueue_.push_back(commandDataString);
	sema_->Release();
	return 1;
}

void MQTTSub::SubThread()
{
	mqttServer.InitData(configData_);
	
	//需要修改
	mqttServer.deviceId = "1";
	
	mqttServer.messageArrived = MessageProcessingCallbacks;
	
	while (!bStop_)
	{
	}
}




void MQTTSub::OnDeliveryComplete(void* context, MQTTAsync_token token)
{
}



void MQTTSub::OnDeliveryFailure(void* context, MQTTAsync_failureData* response)
{
}

bool MQTTSub::SubscribeTopic(const std::string& topic)
{
	return false;
}

```

```
#pragma once
#include "ToolDefine.h"
#include "CommCnc.h"
#include "mqtt.h"
#pragma comment(lib, "paho-mqtt3a.lib")
#include "DataDefine.h"
#include "ServerLog.h"
#include "CommandTaskQueue.h"
#include "Semaphore.h"
#include <deque>
#include "ServerTaskDequeBase.h"
MQTT mqttServer;

//当客户端从代理接收到消息时的回调
//void MessageProcessingCallbacks(void* context, char* topicName, int topicLen, MQTTAsync_message* message);

class MQTTSub :public ServerTaskDequeBase
{
public:
	MQTTSub();
	~MQTTSub();

	//初始化MQTT数据
	bool InitMQTTData(const ConfigData& data);

	//连接成功时的回调
	void OnConnect(void* context, MQTTAsync_successData* response);
	
	//连接失败时的回调
	void OnConnectFailure(void* context, MQTTAsync_failureData* response);

	//断开服务时的回调
	void OnDisconnect(void* context, MQTTAsync_successData* response);

	//连接丢失时的回调
	void OnConnectionLost(void* context, char* cause);



	//发送成功的回调
	void OnDeliveryComplete(void* context, MQTTAsync_token token);

	//发送失败时的回调
	void OnDeliveryFailure(void* context, MQTTAsync_failureData* response);

	//订阅指定Topic信息
	bool SubscribeTopic(const std::string& topic);

private:
	//清空任务队列
	void ClearTask(const std::string& data, int iType);
	//订阅运行线程
	void SubThread();
	//消息处理线程
	void MessageThread();
	

private:
	//是否停止
	bool bStop_;
	//ip地址
	std::string strIp_;
	//端口
	int iPort_;
	//用户名
	std::string strUserName_;
	//密码
	std::string strPassword_;
	//客户端id
	std::string strClientId_;
	//主题
	std::string strTopic_;
	
	//任务队列 可能思路就是任务队列或者向本地端口进行转发
	std::shared_ptr<CommandTaskQueue> taskQueue_;
	
	std::shared_ptr<std::thread> subThread_;  //运行线程
	std::shared_ptr<std::thread> messageThread_;  //消息处理线程

	std::shared_ptr<TcpClient> tcpClient_;//Tcp客户端


	ConfigData configData_;  //配置数据
	DeviceInitData deviceInitData_;  //设备初始化数据
	
	
public:
	//数据队列
	static std::deque<std::string> dataQueue_;
	static std::shared_ptr<Semaphore> sema_; //信号量
};


```