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
# class Puppy < Dog  # the '<' is what allows the puppy to inherit all traits from a dog.
#
#   def is_cuter?
#     return true
#   end
#
# end
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
#     return "Yip Yip!"
#   end
#
# end




##### Using keyword 'super'

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
#   def roll_over
#     return "*Rolls Over*"
#   end
# end
#
#
# class Puppy < Dog
#
#   def is_cuter?
#     return true
#   end
#
#   def speak
#     return "Yip Yip!"
#   end
#
#   def roll_over
#     super + "...and begs for treat"
#   end
#
# end
#
# pup = Puppy.new("Rosie")
# puts pup.speak
# puts pup.roll_over



##################################
#####     LETS DIG IN        #####
##################################

  #Look at the code below (There are four classes. What are their relationships to each other?)
  #Look at the tests below and predict what is going to happen.
  #Then uncomment the tests and run the code!
  #If the ouput is different than expected, discover why.

  #If time, Play around with more of the functionality of the classes! (create more instance objects, call all the methods!)

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
        current_date = Date.now

        new_post = Post.new(title: post[:title], content: post[:content], date: current_date)

        @posts << new_post
      end

      def see_announcements
        return Announcement.see_announcements
      end

    end



    class Admin < User
      attr_reader :admin

      def initialize(user_data)
        super
        @admin = true
      end

      def make_announcement(announcement)
        Announcement.add_announcement(title: announcement[:title], content: announcement[:content], author: self)
      end
    end



    #TESTS:
    admin1= Admin.new(name: "Dorthy", email: "admin@emailadmin.com" )
    admin1.make_announcement(title: "testing", content: "This is a test")

    user1 = User.new(name: "Sophia", email: "email@email.com")
    print user1.see_announcements

    #Create another admin.
      #Have that admin create an announcement

   #Will user1 be able to see announcements created by both admins?


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
