## Parameter Types

### gqlRequestProperty
Used to initialize one of two possible GraphQl body properties:
- query
- variables

### bodyParsingType
Used for parsing responses body:
- arrayBuffer
- formData
- blob
- json
- text

## Action Steps
I send {method} request to {url} and save response as {key}  
I send {method} request to {url} with headers {headers} and save response as {key}  
I send {method} request to {url} with qs {params} and save response as {key}  
I send {method} request to {url} with headers {headers} with qs {params} and save response as {key}  
I send {method} request to {url} with Body {requestBody} and save response as {key}  
I send {method} request to {url} with headers {headers} with Body {requestBody} and save response as {key}  
I send {method} request to {url} with qs {params} and Body {requestBody} and save response as {key}  
I send {method} request to {url} with headers {headers} with qs {params} and Body {requestBody} and save response as {key}  
I send {method} request and save response as {key} to {url} with Body: [requestBody]  
I parse {response} body as {type}  

## Construction API Steps
I create {method} request {requestKey}  
I add headers to {requestKey}: [headersDataTable]  
I add {requestKey} headers to {headersKey}  
I add body to {requestKey}: [body]  
I add {requestKey} body to {body}  
I add {requestKey} url to {url}  
I send {requestKey} request and save response as {responseKey}  
I add form data body to {requestKey}: [dataTable]  

## GraphQL Steps
I create GraphQL request {requestKey}  
I add {property} to GraphQL {string}: [value]  

## Websocket Steps
I connect to {string} ws endpoint {string}  
I save message from {string} ws endpoint as {string}  
I save message matching {string} from {string} ws endpoint as {string}  
I send {string} message to {string} ws endpoint  
I send message to {string} ws endpoint: [message]  
I close {string} ws connection  