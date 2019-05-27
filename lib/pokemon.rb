class Pokemon

    attr_accessor :name, :type, :db, :hp
    attr_reader :id
    
    def initialize(id:, name:, type:, db:, hp: nil)      
        @id = id
        @name = name
        @type = type 
        @db = db
        @hp = hp
    end 

    def self.save(name, type, db) 
        sql = <<-SQL
            INSERT INTO pokemon (name, type)
            VALUES (?, ?)
        SQL
        
        db.execute(sql, name, type) 
    end
    
    def self.find(id, db) 
        sql = "SELECT * FROM pokemon WHERE id = ?"  

        result = db.execute(sql, id)[0]
        #binding.pry  
        Pokemon.new(id:result[0], name:result[1], type:result[2], hp:result[3], db:db)
        #binding.pry  
    end 

    def alter_hp(hp, db)
        sql = "UPDATE pokemon SET hp = ? WHERE id = ?"

        db.execute(sql, hp, id) 
    end 

end


    
# Notes for questions to resolve in AAQ explanatory walkthrough of this lab and 
# remaining unresolved questions.

# Why is result[3] returning nil in pry? Earlier the pry return was the value
# (integer) 60 for the added column hp, which made sense to pass first bonus
# test - pokemon knows it's default hp of 60. Before, the return for result[3]
# was 60 ,but the test was not passing. Now the pry return is nil and yet the 
# test is passing?
  
# Further understand the implications of db being passed in as arguments - this
# must be a specific circumstance relating to this particular test specs, and not
# in typical ORM application?

# Explain/understand the commented out instructions in schema_migration.sql file
# specifically the following line:
# -- It should create a table in a new table in the db/ directory.

# Explain/understand the differences between my code in this pokemon class model
# and the code in alternate pokemon.rb (see file directory) specically the use or
# differences in the use of bound parameters.