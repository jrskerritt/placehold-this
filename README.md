PlaceholderFactory
==================

About
-----
PlaceholderFactory is a [Sinatra](https://github.com/sinatra/sinatra) application that serves up custom placeholder images.


Installation
------------
Install [ImageMagick](http://www.imagemagick.org/script/index.php).  
It's available via apt-get, brew, yum, or [binary release](http://www.imagemagick.org/script/binary-releases.php)

Run `bundle install` in the application folder.


Start the application
---------------------
`ruby app.rb`


Usage
-----
Place your images in the `images` directory. You can then make requests to `http://localhost:4567/{width}/{height}` supplying the desired width and height. The application determines which image best matches the requested dimensions, giving priority to preserving orientation and cropping to fit.

You can also group images into families by creating directories in the images directory. For example, if there is a directory named `penguin` inside of `images` that contains images of penguins, you can make a request for a 400x300 penguin image by making a request to `http://localhost:4567/penguin/400/300`.



License
-------
Copyright (C) 2014 Jim Skerritt, Tom Grochowicz

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.