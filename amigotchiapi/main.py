#!/usr/bin/env python
#
# Copyright 2007 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

import urllib
import datetime
import random

from google.appengine.ext import webapp
from google.appengine.ext.webapp import util
from google.appengine.ext import db

from django.utils import simplejson as json

class User(db.Model):
    id = db.StringProperty(required=True)
    created = db.DateTimeProperty(auto_now_add=True)
    updated = db.DateTimeProperty(auto_now=True)
    name = db.StringProperty(required=True)
    profile_url = db.StringProperty(required=True)
    access_token = db.StringProperty(required=True)
    pet_created = db.DateTimeProperty()
    pet_updated = db.DateTimeProperty(auto_now=True)
    pet_name = db.StringProperty()
    hunger = db.IntegerProperty()
    pet_type = db.StringProperty()
    last_fed = db.DateTimeProperty()
    last_checkin = db.DateTimeProperty()
    happiness = db.IntegerProperty()
    bathroom = db.IntegerProperty()
    accessory = db.StringProperty()
    age = db.IntegerProperty()
    last_bathroom = db.DateTimeProperty()
    pic = db.BlobProperty()

##checkin
class Checkin(db.Model):
    checkindate = db.DateTimeProperty(auto_now_add=True)
    title = db.StringProperty(required=True)
    owner = db.ReferenceProperty(User)
    place_id = db.StringProperty(required=True)
    location = db.GeoPtProperty(required=True)

def petToDict(pet, msg=""):
    retpet = {}

    retpet["name"] = pet.pet_name
    retpet["age"] = pet.age
    retpet["type"] = pet.pet_type
    retpet["hunger"] = pet.hunger
    retpet["happiness"] = pet.happiness
    retpet["bathroom"] = pet.bathroom
    retpet["accessory"] = pet.accessory
    retpet["message"] = msg

    return retpet

class MainHandler(webapp.RequestHandler):
    def get(self):
        self.response.out.write('Hello world!')

class UserLoginHandler(webapp.RequestHandler):
    def get(self):
        self.response.out.write("doesn't work here buddy")

    def post(self):
        access_token = self.request.get("access_token")

        # Download the user profile and cache a local instance of the
        # basic profile info
        profile = json.load(urllib.urlopen(
            "https://graph.facebook.com/me?" +
            urllib.urlencode(dict(access_token=access_token))))

        if profile.get("error"):
           self.error(500)
        else:
           user_id = profile["id"]

           user_key = db.Key.from_path('User', user_id)
           current_user = User.get(user_key)
            
           if current_user == None:
               user = User(key_name=str(profile["id"]), id=str(profile["id"]),
                        name=profile["name"], access_token=access_token,
                        profile_url=profile["link"],
                        pet_name=profile["first_name"], pet_type="dragon" , 
                        bathroom=1, age=0, happiness=30, hunger=10, accessory="none",
                        last_fed=datetime.datetime.now(), last_bathroom=datetime.datetime.now(), last_checkin=datetime.datetime.now())
               user.put()
           else:
               current_user.access_token = access_token
               current_user.put()
        self.response.out.write(json.dumps(profile))

###
class PetCleanHandler(webapp.RequestHandler):
    def get(self):
        self.response.out.write("doesn't work here buddy")

    def post(self):

        access_token = self.request.get("access_token")

        # Download the user profile and cache a local instance of the
        # basic profile info
        profile = json.load(urllib.urlopen(
            "https://graph.facebook.com/me?" +
            urllib.urlencode(dict(access_token=access_token))))

        if profile.get("error"):
           self.error(500)
        else:
            user_id = profile["id"]

            user_key = db.Key.from_path('User', user_id)
            current_user = User.get(user_key)
            current_user.bathroom = 0

            current_user.last_bathroom = datetime.datetime.now()
            current_user.put()

            self.response.out.write(json.dumps(petToDict(current_user, msg="cleaned up!") ))
##
###
class PetFeedHandler(webapp.RequestHandler):
    def get(self):
        self.response.out.write("doesn't work here buddy")

    def post(self):

        access_token = self.request.get("access_token")

        # Download the user profile and cache a local instance of the
        # basic profile info
        profile = json.load(urllib.urlopen(
            "https://graph.facebook.com/me?" +
            urllib.urlencode(dict(access_token=access_token))))

        if profile.get("error"):
           self.error(500)
        else:
           user_id = profile["id"]

           user_key = db.Key.from_path('User', user_id)
           current_user = User.get(user_key)

           right_now = datetime.datetime.now()
           difference_without_checkin = right_now - current_user.last_checkin
           seconds_without_checkin = difference_without_checkin.seconds

           minutes_without_checkin = seconds_without_checkin / 60
           days_without_checkin = difference_without_checkin.days

           if current_user.age == 0 or days_without_checkin > 0 or minutes_without_checkin > 30:
	          self.response.out.write(json.dumps(petToDict(current_user, msg="Hey checkin and get me some food!")))
           else:
              current_user.hunger = current_user.hunger - 1
              if current_user.hunger < 0:
                 current_user.hunger = 0
              current_user.last_fed = datetime.datetime.now()
              current_user.put()
              self.response.out.write(json.dumps(petToDict(current_user, msg="Yummy!")))
###
class PetHappyHandler(webapp.RequestHandler):
    def get(self):
        self.response.out.write("doesn't work here buddy")

    def post(self):

        access_token = self.request.get("access_token")

        # Download the user profile and cache a local instance of the
        # basic profile info
        profile = json.load(urllib.urlopen(
            "https://graph.facebook.com/me?" +
            urllib.urlencode(dict(access_token=access_token))))

        if profile.get("error"):
           self.error(500)
        else:
            user_id = profile["id"]

            user_key = db.Key.from_path('User', user_id)
            current_user = User.get(user_key)

            current_user.happiness = current_user.happiness + 1

            if current_user.happiness > 30:
                current_user.happiness = 30
            current_user.put()
            random_pet_sayings = ["Thanks for petting me!", 
                                  "One day I'll be a big dragon!", 
                                  "You're the best!", 
                                  "Will I be in this phone forever?"
                                  ]

            self.response.out.write(json.dumps(petToDict(current_user, msg=random.choice(random_pet_sayings))))
###
class PetLoadHandler(webapp.RequestHandler):
    def get(self):
        self.response.out.write("doesn't work here buddy")

    def post(self):

        access_token = self.request.get("access_token")

        # Download the user profile and cache a local instance of the
        # basic profile info
        profile = json.load(urllib.urlopen(
            "https://graph.facebook.com/me?" +
            urllib.urlencode(dict(access_token=access_token))))

        if profile.get("error"):
           self.error(500)
        else:
            user_id = profile["id"]
            user_key = db.Key.from_path('User', user_id)

            current_user = User.get(user_key)
            pet = {}
            right_now = datetime.datetime.now()
            difference_without_food = right_now - current_user.last_fed
            seconds_without_food = difference_without_food.seconds

            minutes_without_food = seconds_without_food / 60
            days_without_food = difference_without_food.days
            current_user.hunger = current_user.hunger + 1*minutes_without_food

            if current_user.hunger > 20:
               current_user.hunger = 20

            difference_without_cleaning = right_now - current_user.last_bathroom
            seconds_without_cleaning = difference_without_cleaning.seconds

            minutes_without_cleaning = seconds_without_cleaning / 60
            days_without_cleaning = difference_without_cleaning.days
            current_user.bathroom = current_user.bathroom + 1*minutes_without_cleaning
            if current_user.bathroom > 10:
               current_user.bathroom = 10        

            current_user.happiness = current_user.happiness - (current_user.bathroom/3) - current_user.hunger

            self.response.out.write(json.dumps(petToDict(current_user, "I love you!")))
###
class CheckinHandler(webapp.RequestHandler):
    def get(self):
        self.response.out.write("doesn't work here buddy")

    def post(self):

        access_token = self.request.get("access_token")

        checkin = {}
        checkin["title"] = self.request.get("title")        
        checkin["place_id"] = self.request.get("place_id")  
        checkin["lon"] = float(self.request.get("lon"))
        checkin["lat"] = float(self.request.get("lat"))

        # Download the user profile and cache a local instance of the
        # basic profile info
        profile = json.load(urllib.urlopen(
            "https://graph.facebook.com/me?" +
            urllib.urlencode(dict(access_token=access_token))))

        if profile.get("error"):
           self.error(500)
        else:
            user_id = profile["id"]
            user_key = db.Key.from_path('User', user_id)

            current_user = User.get(user_key)
            current_user.age = current_user.age + 1

            savethis = Checkin( title=checkin["title"], owner=current_user, place_id=checkin["place_id"], location=db.GeoPt(checkin["lat"], checkin["lon"]) )
            savethis.put()

            checkin_msg = "Checked into %s." % checkin["title"]
            prize_msg =  ""

            if current_user.age == 1:
               checkin_msg = "First Checkin!"
               current_user.accessory = "cowboy hat"
               prize_msg = " You've unlocked the Bellardo Hat!"
            elif current_user.age == 2:
               checkin_msg = "Nice you found glasses!"
               current_user.accessory = "glasses"
               prize_msg = " You're on a roll! "

            msg = checkin_msg + prize_msg
            
            current_user.last_checkin = datetime.datetime.now()
            current_user.put()

            self.response.out.write(json.dumps(petToDict(current_user, msg)))

##
###
class NearbyHandler(webapp.RequestHandler):
    def get(self):
        self.response.out.write("doesn't work here buddy")

    def post(self):

        access_token = self.request.get("access_token")
        #nearby = {}
        #nearby["lon"] = float(self.request.get("lon"))
        #nearby["lat"] = float(self.request.get("lat"))

        # Download the user profile and cache a local instance of the
        # basic profile info
        profile = json.load(urllib.urlopen(
            "https://graph.facebook.com/me?" +
            urllib.urlencode(dict(access_token=access_token))))

        if profile.get("error"):
           self.error(500)
        else:
            nearby = []
            q = Checkin.all()
            q.order("checkindate")
            results = q.fetch(100)
            for checkin in results:
               nearby.append(dict(lat=checkin.location.lat,lon=checkin.location.lon, title=checkin.title, owner=checkin.owner.name))
            self.response.out.write(json.dumps(nearby))


def main():
    application = webapp.WSGIApplication([('/', MainHandler),
                                          ('/user/login', UserLoginHandler),
                                          ('/pet/load', PetLoadHandler),
                                          ('/pet/feed', PetFeedHandler),
                                          ('/pet/happy', PetHappyHandler),
                                          ('/pet/clean', PetCleanHandler),
                                          ('/checkin', CheckinHandler),
                                          ('/nearby', NearbyHandler)],
                                         debug=True)
    util.run_wsgi_app(application)


if __name__ == '__main__':
    main()
