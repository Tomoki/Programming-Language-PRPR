label "fizzbuzz" to:
    for i=0 to i is 16 do:
        if i mod 15 is 0 then:
            print "FizzBuzz"
        else:
            if i mod 5 is 0 then:
                print "Buzz"
            else:
                if i mod 3  is 0 then:
                    print "Fizz"
                else:
                    print i
        i = i + 1

goto "fizzbuzz"
