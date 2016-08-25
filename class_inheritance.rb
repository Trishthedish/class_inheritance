##################################
#####    CLASS INHERITANCE   #####
##################################

  #Inheritance is used to model the behaviors of one class after another. We would want to do this when two objects have a clear chain of ownership. Often the parent class, or base class, is more general while the child, or subclass, is more specific.

##################################
#####     LEARNING GOALS     #####
##################################

  # Describe objects in terms of is-a relationships

  # Use inheritance to indicate a hierarchy of ownership or lineage between classes

  # Explore overriding method definitions in sublcasses

  # Use super to invoke the behavior of a base class in a _subclass



##################################
#####       DEMO TIME!       #####
##################################

##### Inheriting Methods
# writing this like this is far to big. AND NOT DRY
# class Cat
#   attr_accessor :name
#   attr_reader :breed
#
#   def initialize(name, breed ="Mutt")
#     @name = name
#     @breed = breed
#   end
#   def speak
#
#   end
#
# end
#
# class Cat
#   attr_accessor :name
#   attr_reader :breed
#
#   def initialize(name, breed ="Mutt")
#     @name = name
#     @breed = breed
#   end
#   def speak
#
#   end
#
# # end
# class Animal
#   attr_accessor :name
#   attr_reader :breed
#
#   def initialize(name, breed ="Mutt")
#      @name = name
#      @breed = breed
#   end
# end
#
#
# class Dog < Animal
#   def speak
#     return "Woof!"
#   end
# end
#
# class Puppy < Dog  # the '<' is what allows the puppy to inherit all traits from a dog.
#
#   def is_cuter?
#     return true
#   end
# end
#
# pup = Puppy.new("George", "English Bulldog")
# puts pup.speak
#
#
# class Cat < Animal
#   def open_can_of_tuna
#     return "Meow"
#   end
# end
#
# kitty = Cat.new("Asterisk", "Tabby")
# puts kitty.name
# puts kitty.open_can_of_tuna
#
#
#
#
# ##### Overiding Methods
#
# class Dog
#   attr_accessor :name
#   attr_reader :breed
#
#   def initialize(name, breed = "Mutt")
#     @name = name
#     @breed = breed
#   end
#
#   def speak
#     return "Woof!"
#   end
#
# end
#
#
# class Puppy < Dog
#
#   def is_cuter?
#     return true
#   end
#
#   def speak #What happens if we give our child class a method the same name as a method in the parent class it's inheriting from?
#
#     # it overode the original class method. It will ignore the other one previously created.
#     return "Yip Yip!"
#   end
#
# end
#
# pup = Puppy.new("Winston", "Schnauzer")
# puts pup.speak




##### Using keyword 'super'

# class Dog
#   attr_accessor :name
#   attr_reader :breed
#
#                 # (name, breed = "Mutt")
#                 #hash // without hash
#   def initialize(hash)
#     @name = hash[:name]
#     @breed = hash[:breed]
#     puts speak
#     # @name = name
#     # @breed = breed
#   end
#
#   def speak
#     return "Woof!"
#   end
#
#   def roll_over
#     return "*Rolls Over*"
#   end
# end
#
#
# class Puppy < Dog
#   attr_accessor :name, :breed, :speak
#
#   def initialize(hash)
#     super
#     @age = hash[:age]
#   end
#
#   def is_cuter?
#     return true
#   end
#
#   def speak
#     return "Yip Yip!"
#   end
# # exact same name as Parent Dog method.
#   def roll_over
#     super + "...and begs for treat"
#   end
#
# end
#
# pup = Puppy.new({name: "Rosie", breed: "Great Dane", age: 20})
# puts pup.speak
# puts pup.roll_over
# puts pup.age
# puts pup.name



##################################
#####     LETS DIG IN        #####
##################################

  #Look at the code below (There are four classes. What are their relationships to each other?)
  #Look at the tests below and predict what is going to happen.
  #Then uncomment the tests and run the code!
  #If the ouput is different than expected, discover why.

  #If time, Play around with more of the functionality of the classes! (create more instance objects, call all the methods!)
    #
    class Post
      attr_accessor :title, :content
      attr_reader :date

      def initialize(post_data)
        @title = post_data[:title]
        @content = post_data[:content]
        @date = Time.new
      end

    end


    class Announcement < Post
      @@announcements = []

      attr_reader :author

      def initialize(post_data)
        super
        @author = post_data[:author]
      end

      def self.add_announcement(announcement_data)
        @@announcements << self.new(
        title: announcement_data[:title],
        content: announcement_data[:content],
        author: announcement_data[:author]
        )
      end

      def self.see_announcements
        return @@announcements
      end
    end




    class User
      attr_accessor :name, :email, :birthdate

      def initialize(personal_info)
        @name = personal_info[:name]
        @email = personal_info[:email]
        @birthdate = personal_info[:birthdate]
        @user_created = Time.new
        @posts = []
      end

      def add_post(post)
        new_post = Post.new(title: post[:title], content: post[:content], date: current_date[])
    # new hash
        @posts << new_post
      end

      def see_announcements
        return Announcement.see_announcements
      end

    end



    class Admin < User
      attr_reader :admin
          # its going to use user data
      def initialize(user_data)
        super
        @admin = true
      end

      def make_announcement(announcement)
        Announcement.add_announcement(title: announcement[:title], content: announcement[:content], author: self)
      end
    end
require 'awesome_print'
    #
    #
    # #TESTS:
    admin1= Admin.new(name: "Dorthy", email: "admin@emailadmin.com" )
    admin1.make_announcement(title: "testing", content: "This is a test")
    ap admin1.add_post(title: "new post", content: "something really interesting")

    admin2 = Admin.new(name: "Jamie", email: "fake@gmail.com")
    admin2.make_announcement(title: "2nd Test", email: "joe.com", content: "see annoucments" )
    print admin2.see_announcements



    user1 = User.new(name: "Sophia", email: "email@email.com")
    ap user1.see_announcements


    #Create another admin.
      #Have that admin create an announcement


   #Will user1 be able to see announcements created by both admins?


#Questions to ponder...
   # Is a user able to make an announcement?

  #  no?

   # Is an admin able to view all the annoucements that have been made, even by other admins?
   # Why is announcement inheriting from Post?

# yes, but not others?

##################################
#####      WHY USE THIS?     #####
##################################

#DRY Code

#If there are multiple classes that have repeated code, a super should be created that those classes can inherit from!

#EX: Fake Gem


##################################
#####       VOCABULARY       #####
##################################

#Parent Class  aka Super Class
    #More general

#Child Class aka Sub Class
  #More Specific
