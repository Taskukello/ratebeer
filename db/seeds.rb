b1 = Brewery.create name:"Koff", year:1897
b2 = Brewery.create name:"Malmgard", year:2001
b3 = Brewery.create name:"Weihenstephaner", year:1042
w = Brewery.create style:"Weizen",  description:"Leipäteksti" 
l  = Brewery.create style:"Lager",  description:"Leipätekstiä lisää" 
p  = Brewery.create style:"Pale ale",  description:"Leipätekstiä edelleenkin" 
i  = Brewery.create style:"IPA",  description:"Leipätekstiä, miksi edes luet enään?" 
p = Brewery.create style:"Porter",  description:"Leipätekstiä eikä miksikään muutu!" 
b1.beers.create name:"Iso 3", style:l
b1.beers.create name:"Karhu", style:l
b1.beers.create name:"Tuplahumala", style:l
b2.beers.create name:"Huvila Pale Ale", style:p
b2.beers.create name:"X Porter", style:p
b3.beers.create name:"Hefeweizen", style:w
b3.beers.create name:"Helles", style:l

 User.create username: "Admin", password: "Admin1", Admin: true
 User.create username: "piraatti", password: "Piraatti1", Admin: false
  User.create username: "roisto", password: "Roisto1", Admin: false