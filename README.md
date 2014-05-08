# placehold-this


## About
placehold-this is a [Sinatra](https://github.com/sinatra/sinatra) application that serves up custom placeholder images.


## Installation
Install [ImageMagick](http://www.imagemagick.org/script/index.php).  
It's available via apt-get, brew, yum, or [binary release](http://www.imagemagick.org/script/binary-releases.php)

Run `bundle install` in the application folder.


## Start the application
`ruby app.rb`


## Usage

### Port configuration
The port that the application runs on is configurable inside of `config.yml`.

### Adding images
Place your images in the `images` directory. You can then make requests to `http://localhost:{port}/{width}/{height}` supplying the desired width and height. The application determines which image best matches the requested dimensions, giving priority to preserving orientation and cropping to fit.

### Image families
You can also group images into families by creating directories in the images directory. For example, if there is a directory named `penguin` inside of `images` that contains images of penguins, you can make a request for a 400x300 penguin image by making a request to `http://localhost:{port}/penguin/400/300`.

Any images in family directories will also be considered part of the "global" family. That is, if there is a 400x600 image `cactus.jpg` in the directory `images/desert` and a request is made to `http://localhost:{port}/400/600`, the response will be `cactus.jpg`.
