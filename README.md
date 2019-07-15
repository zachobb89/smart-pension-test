The test:
Design a vending machine using Ruby.
-
Write a program that: Receives a log file as an argument (webserver.log is provided) e.g.: ./<parse> webserver.log. Returns the following:
  
a list of webpages with most page views ordered from most pages views to less page views e.g.:
/home 90 visits /index 80 visits etc... 

a list of webpages with most unique page views also ordered e.g.:
/about/2 8 unique views /index 5 unique views etc...
  

My solution
-
I produced a SOLID, object oriented model of a vending machine in Ruby.

I used RSpec for testing.  

The FileParser is initialized with by passing a file which is then passed to the Parse class using dependency injection. The Parse class first checks if the file is a correct path and then creates a new hash by splitting the file by '/'. The title is stored in the hash as the key with the ip addresses stored in an array as the value. 

When get_most_views is called on the instance of the FileParser, it is passed to the most_views in the View Class. The get_most_views method then passes the title and uniquness method to the view_getter method. 

The view_getter method then uses the create_count method to create an array from the entries, ensuring that the total count for each page is returned using a ternery operator. This list is then ordered by the sorted_list method and finally the ordered list and the title is then passed to the show_view method to display the list. 

The process above is the same when get_unique_views is called on the FileParser instance, except that only unique views are counted. 

Taking it further
-
I have added methods to find the total and unique views for a single page. 
