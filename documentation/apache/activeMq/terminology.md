# ActiveMQ - Terminology

## Queue

If you store a message in a queue, the message will be received exactly by one consumer. If there is no consumer present the messages will be stored and the message will be processed when a consumer registers.

Its like a Load Balander in JMS.

## Topic

Topic implements the Observer Pattern. Every subscriber will receive the message. So zero to many consumers can be subscribed. If there is no consumer present the message will not be stored and it is gone.

### durable Subscriber on topics

If an subscriber stopped he will not get the messages because he has no active subscription at the moment. But if it is an durable subscriber there will be a queue for the messages for every durable subscriber on the topic. In this queue the messages are stored and if the durable subscriber restarts and comes back he will get the messages which are stored in the queue.

