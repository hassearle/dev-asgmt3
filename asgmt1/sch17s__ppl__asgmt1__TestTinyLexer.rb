#RESOURCES 
	#REFRENCE1
		#zanbri
		#http://stackoverflow.com/questions/7911669/create-file-in-ruby


load "/home/asearle/dev/asgmt3_/asgmt1/sch17s__ppl__asgmt1__TinyToken.rb"
load "/home/asearle/dev/asgmt3_/asgmt1/sch17s__ppl__asgmt1__TinyScanner.rb"


# filename.txt below is simply the "source code"
# that you write that adheres to your grammar rules
# if it is in the same directory as this file, you can
# simply include the file name, otherwise, you will need
# to specify the entire path to the file as we did above
# to load the other ruby modules
scan = Scanner.new("/home/asearle/dev/asgmt1/sch17s__ppl__asgmt1__input.txt")
tok = scan.nextToken()
@output = ""

while (tok.get_type() != Token::EOF)
   puts "#{tok.get_type()} #{tok}\n"
   #refrence1
   @output << "#{tok.get_type()} #{tok}\n"
   tok = scan.nextToken()
end 

puts "#{tok.get_type()} #{tok}\n"
@output << "#{tok.get_type()} #{tok}\n"

File.open("kss0024output.txt", "w") {|f| f.write(@output) }