/* * * * * * * * * * * * * * * * * * * * * * * * *
 * Description: HIT3324 Web Application Development
 *              Assignment Two
 *              AJAX Request/Response Scripts
 *      Author: Alex Cummaudo
 *        Date: 10 Oct 2013
 * * * * * * * * * * * * * * * * * * * * * * * * */

/**
 *
 * Create Request
 * ==============
 *
 * Returns an XML object depending on the browser
 * being used (W3C standards vs. MS standards)
 *
 */
function createRequest() 
{
    if (window.XMLHttpRequest)  { return new XMLHttpRequest; }                      //!< W3C Standard
    else                        { return new ActiveXObject("Microsoft.XMLHTTP"); }  //!< MS  Standard
}

//! Global Variables since accessible everywhere
var xhrObj = createRequest();  //!< Create an XMLHttpRequest using createRequest
var xhrResponse = "";          //!< XHR Response text

/**
 *
 * Send Request
 * ============
 *
 * Sends a POST/GET requests to the serverPage parameter
 * with the queryString parameter as the query string on
 * the URL, executing the eventHandler function
 * passed when page response is ready
 *
 */
function sendPostRequest(serverPage, eventHandler, data) 
{
    //! Send request as GET to serverPage?queryString
    xhrObj.open("POST", serverPage, true);
    xhrObj.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

    xhrObj.onreadystatechange = function() { readyStateRecieved(eventHandler); }    //!< Attach event handler function, passing in
                                                                                    //!< the eventHandler to readyStateRecieved
    xhrObj.send(data);                                                              //!< As it's a GET, no HTTP request body
}

function sendGetRequest(serverPage, eventHandler, data) 
{
    //! Send request as GET to serverPage?queryString
    xhrObj.open("GET", serverPage+"?"+data, true);
    xhrObj.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

    xhrObj.onreadystatechange = function() { readyStateRecieved(eventHandler); }    //!< Attach event handler function, passing in
                                                                                    //!< the eventHandler to readyStateRecieved
    xhrObj.send(null);                                                              //!< As it's a GET, no HTTP request body
}

/**
 *
 * Ready State Recieved
 * ====================
 *
 * Executes the eventHandler function passed when the
 * sever has recieved ready state and data was recieved.
 *
 */
function readyStateRecieved(eventHandler)
{
    if (xhrObj.readyState == 4 && xhrObj.status == 200)     //!< XHR has data loaded and server says OK
    {
        xhrResponse = xhrObj.responseText;                  //!< Response text recieved; store as response
        eventHandler();                                     //!< Execute the event handler
    }
}