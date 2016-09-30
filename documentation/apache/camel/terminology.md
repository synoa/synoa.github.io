# Terminology

## Endpoint

The term endpoint is often used when talking about inter-process communication. For example, in client-server communication, the client is one endpoint and the server is the other endpoint.

The term endpoint is ambiguous in at least two ways
1. It is ambiguous because it might refer to an address or to a software entity contactable at that address. 
2. It is ambiguous in the granularity of what it refers to: a heavyweight versus lightweight software entity, or physical address versus logical address.

It is useful to understand that different people use the term endpoint in slightly different (and hence ambiguous) ways because Camel's usage of this term might be different to whatever meaning you had previously associated with the term.

Examples:

* A JMS queue
* A web service
* A file
* An FTP server
* An email address
* A POJO (plain old Java object)

## Camel Context

A CamelContext object represents the Camel runtime system. You typically have one CamelContext object in an application.

## CamelTemplate

The CamelTemplate class is a thin wrapper around the CamelContext class. It has methods that send a Message or Exchange to an Endpoint.

## Components

Component is confusing terminology; EndpointFactory would have been more appropriate because a Component is a factory for creating Endpoint instances.

## Message

The Message interface provides an abstraction for a single message, such as a request, reply or exception message.
In Camel terminology, the request, reply and exception messages are called _in_, _out_ and _fault_ messages.

## Exchange

There are concrete classes that implement the Exchange interface for each Camel-supported communications technology.
An implementation might call ```exchange.getIn()``` to get the input message and process it. If an error occurs during processing then the method can call ```exchange.setException()```.

### Simple Class Diagramm of an Exchange

```
+-------------------------------------+
| Exchange                            |
+-------------------------------------+
| properties: Map <String,Object>     |
|     +----------------------------+  |
| in: | Message                    |  |
|     +----------------------------+  |
|     | header: Map<String,Object> |  |
|     | body: Object               |  |
|     +----------------------------+  |
+-------------------------------------+
```

We see that an exchange holds 2 attributes:

* properties (holds data which will not be provided to 3rd party services
* in (holds an Message Object)

The Message object has 2 Attributes

* header (holds also data which will be provided to 3rd party services)
* body (The real content of the message)

## Processor

The Processor interface represents a class that processes a message.

## Route

A route is the step-by-step movement of a Message from an input queue, through arbitrary types of decision making (such as filters and routers) to a destination queue (if any). 

Camel provides two ways for an application developer to specify routes:

1. Specify route information in an XML file.
2. What Camel calls a Java DSL
