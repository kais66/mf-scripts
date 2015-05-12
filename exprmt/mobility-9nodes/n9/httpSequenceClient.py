import time
import httplib
import socket
import sys
import random

HTTP_ERROR_CODES = [400, 401, 402, 403, 404, 500, 501, 502, 503]
HTTP_SUCCESS_CODES = [200]


class HttpSequenceClient:
    """
    HTTP client that sequencially request a list of files
    """

    def __init__(self, destinationHost, localTO=0, socketTO=0, files=None, debug=False):
        """
            * files: list of files
        """
        self.files = files
        self.dhost = destinationHost
        self.localTO = localTO
        self.socketTO = socketTO
        self.debug = debug
        if self.debug:
            print "Parameters ", self.files, " ", self.dhost, " ", self.localTO, " ", self.socketTO

    def reliableHTTPRequest(self, method, URL):
        """
            Performs an HTTP request. Keeps looping until either the content is retrieved or the server returs an error
        """
        code = 0
        while code not in HTTP_ERROR_CODES and code not in HTTP_SUCCESS_CODES:
            if self.debug:
                print "Retrieving: ", self.dhost, URL

            try:
                if self.socketTO > 0:
                    conn = httplib.HTTPConnection(self.dhost, timeout=self.socketTO)
                else:
                    conn = httplib.HTTPConnection(self.dhost)
                conn.request(method, URL)
                response = conn.getresponse()
                if response.status in HTTP_SUCCESS_CODES:
                    if self.debug:
                        print "Received success status: ", response.status, "\nResponse:", response.reason
                    data = response.read()
                    print data
                    if self.debug:
                        length = response.getheader("Content-Length")
                        print "Response size: ", length
                elif response.status in HTTP_ERROR_CODES:
                    if self.debug:
                        print "Received error status: ", response.status, "\nResponse:", response.reason
                    data = None
                else:
                    if self.debug:
                        print "Retrying in: ", self.localTO
                    time.sleep(self.to)
                conn.close()
                break
            except (httplib.HTTPException, socket.error) as e:
                if self.debug:
                    print "Exception: ", e
                    print "Retrying in: ", self.localTO
                time.sleep(self.localTO)


    def executeTask(self, files=None):
        """
            Sequencially request files
        """
        if files is not None:
            fileList = files
        elif self.files is not None:
            fileList = self.files
        else:
            return
        for file in fileList:
            self.reliableHTTPRequest("GET", file)


if __name__ == "__main__":
    argc = len(sys.argv)
    stime = 0.0
    if argc>1:
        random.seed()
        stime = float(sys.argv[1])*random.random()
        if float(sys.argv[1]) < 0:
          stime = 9.0 
        time.sleep(stime)

    server = sys.argv[2] + ':80'
    client = HttpSequenceClient(server, localTO=0, debug=True)
    #client = HttpSequenceClient("localhost:80", localTO=0, debug=True)
    #files = ["/index.html", "/something.html"]
    files = ["/test1_subset/dummy_10M"]

    start = time.time() * 1000
    client.executeTask(files)
    end = time.time() * 1000

    f = open('/var/log/mf/http.log', 'w')

#    line = '===' + str(stime) + '\n'
#    print line
#    f.write(line)
    
    line = str(start) + ', ' + str(end) + ', ' + str(end-start) + ', ' + str(stime) + '\n'
    print line
    f.write(line)

    f.close()

