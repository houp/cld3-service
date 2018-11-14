# Compact Language Detector 3 API
This is a very simple web service API for exposing Google Compact Language Detector 3 (CDL3) library (https://github.com/Google/cld3) via a REST / JSON web api.

It uses a Python wrapper for CDL3 available here: https://github.com/Elizafox/cld3 (in fact a slightly changed version forked by me here: https://github.com/houp/cld3).

The service is implemented using Python3 and Flask and hosted in a Docker image.

## How to run with Docker
To build and run the docker image do:

    git clone https://github.com/houp/cld3-service.git
    cd cld3-service
    docker build -t cld .
    docker run -d -p 1337:80 cld

This will open port 1337 on your local machine with access to the service.

## How to run standalone

You need to have Python3 with following libraries: Cython, protobuf, flask. Assuming you have pip installed you can grab these dependencies via:

    pip3 install Cython flask protobuf
   
  Now all you need to do is to edit app.py file and find this line:
  

    app.run()

  and change it to:
  

    app.run(host='0.0.0.0',port=1337)

And finally start app.py with python. The service will start on port 1337 on all of your network interfaces.



 ## How to use the API
 The only method available is to send a POST request to /detect endpoint with JSON body of the form:
 

    {"sentence": "Ich habe keine problem."}
     
The correct output is in JSON format and looks something like this:

    {
        "is_reliable": true,
        "lang": "de",
        "probability": 0.9999370574951172
    }

The corresponding test curl command for this request is:

        curl --header "Content-Type: application/json" \
      --request POST \
      --data '{"sentence":"Ich habe keine problem."}' \
      http://localhost:1337/detect

Note that the service DOES NOT handle errors nicely.
