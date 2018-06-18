# ProgImage.doc
A specialised image storage and processing engine to be used by other applications which provides high performance programmatic access via its API.

## Set up
To set ProgImage.com, you need to clone this repository, run bundle install, db:create and db:migrate


## Sign up
To sign up, open the terminale and create a new user :
```
User.create(email:"YOUR_EMAIL", password:"YOUR_PASSWORD")

```
The user is created! You can know copy the token displayed in the console.


## Upload a picture
You can upload a picture from a url or a repository path by sending a POST request to http://localhost:3000/api/v1/pictures.
The header of your request should contain the content type, the user email and token.
Example:
```
Content-Type    application/json
X-User-Email    test@test.com
X-User-Token    BaLgKhKd6hsKKVRXywrs
```

The body of your request should be
```
{"picture": [
  {"source": "URL_OR_FILEPATH_OF_YOUR_PICTURE"}
  ]
}

```

Once the request is completed, the API will render the index view with highest from lowest ID.


## Uploading a batch of picture
You can upload a batch of pictures from urls and/or reposity paths by sending a POST request to http://localhost:3000/api/v1/pictures
The header of your request should contain the content type, the user email and token.
Example:
```
Content-Type    application/json
X-User-Email    test@test.com
X-User-Token    BaLgKhKd6hsKKVRXywrs
```

The body of your request should be
```
{"picture": [
  {"source": "URL_OR_FILEPATH_OF_YOUR_1ST_PICTURE"},
  {"source": "URL_OR_FILEPATH_OF_YOUR_2ND_PICTURE"},
  {"source": "URL_OR_FILEPATH_OF_YOUR_3RD_PICTURE"}
  ...
  ]
}

```

Once the request is completed, the API will render the index view with highest from lowest ID.


## Retrieve a picture
You can retrieve a picture by sending a GET request to http://localhost:3000/api/v1/pictures/ID_OF_YOUR_PICTURE
The header of your request should contain the content type, the user email and token.
Example:
```
Content-Type    application/json
X-User-Email    test@test.com
X-User-Token    BaLgKhKd6hsKKVRXywrs
```

Once the request is completed, the API will render the show view of your picture.


## List all pictures
You can list all your pictures by sending a GET request to http://localhost:3000/api/v1/pictures
The header of your request should contain the content type, the user email and token.
Example:
```
Content-Type    application/json
X-User-Email    test@test.com
X-User-Token    BaLgKhKd6hsKKVRXywrs
```

Once the request is completed, the API will render the index view with highest from lowest ID.


## Delete a picture
You can delete a picture by sending a DELETE request to http://localhost:3000/api/v1/pictures/ID_OF_YOUR_PICTURE
The header of your request should contain the content type, the user email and token.
Example:
```
Content-Type    application/json
X-User-Email    test@test.com
X-User-Token    BaLgKhKd6hsKKVRXywrs
```

Once the request is completed, the API will render an empty view with a 204 status.

## Picture format converter
You can convert any picture into jpeg, png, gif and tiff formats by sending a GET request to http://localhost:3000/api/v1/pictures/ID_OF_YOUR_PICTURE/DESIRED_FORMAT
Example:
```
http://localhost:3000/api/v1/pictures/5/jpeg
```


The header of your request should contain the content type, the user email and token.
Example:
```
Content-Type    application/json
X-User-Email    test@test.com
X-User-Token    BaLgKhKd6hsKKVRXywrs
```

Once the request is completed, the API will render the show view of your picture with the desired format.
