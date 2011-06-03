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
           self.response.out.write(json.dumps(profile))
        else:
            user = User(key_name=str(profile["id"]), id=str(profile["id"]),
                        name=profile["name"], access_token=access_token,
                        profile_url=profile["link"],
                        pet_name=profile["first_name"], pet_type="dragon" , 
                        bathroom=1, age=0, happiness=30, hunger=10, accessory="none",
                        last_fed=datetime.datetime.now(), last_bathroom=datetime.datetime.now())
            if user.is_saved() == True:
               pass
            else:
               user.put()
            self.response.out.write(json.dumps(profile))


###
class PetSaveHandler(webapp.RequestHandler):
    def get(self):
        self.response.out.write("doesn't work here buddy")

    def post(self):

        access_token = self.request.get("access_token")
        
        action = self.request.get("action")

        pet_name = self.request.get("name")
        hunger = self.request.get("hunger")
        happiness = self.request.get("happiness")
        bathroom = self.request.get("bathroom")

        # Download the user profile and cache a local instance of the
        # basic profile info
        profile = json.load(urllib.urlopen(
            "https://graph.facebook.com/me?" +
            urllib.urlencode(dict(access_token=access_token))))

        if profile.get("error"):
           self.response.out.write(json.dumps(profile))
        else:
            user_id = profile["id"]
            if action == "feed":
               pet = User( key_name=str(profile["id"]), id=str(profile["id"]), hunger=hunger, bathroom=bathroom, happiness=happiness, last_fed=datetime.datetime.now())
            elif action == "bathroom":
               pet = User( key_name=str(profile["id"]), id=str(profile["id"]), hunger=hunger, bathroom=bathroom, happiness=happiness, last_bathroom=datetime.datetime.now())
            else:
               pet = User( key_name=str(profile["id"]), id=str(profile["id"]), hunger=hunger, bathroom=bathroom, happiness=happiness)
            pet.put()

            user_key = db.Key.from_path('User', user_id)
            current_user = User.get(user_key)
            retpet = {}

            retpet["name"] = current_user.pet_name
            retpet["hunger"] = current_user.hunger
            retpet["last_fed"] = current_user.last_fed
            retpet["happiness"] = current_user.happiness
            retpet["bathroom"] = current_user.bathroom
            retpet["last_bathroom"] = current_user.last_bathroom

            self.response.out.write(json.dumps(retpet))
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
           self.response.out.write(json.dumps(profile))
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
 
            pet["name"] = current_user.pet_name
            pet["hunger"] = current_user.hunger
            pet["happiness"] = current_user.happiness
            pet["bathroom"] = current_user.bathroom
            pet["accessory"] = current_user.accessory

            pet["age"] = current_user.age
            pet["type"] = current_user.pet_type

            self.response.out.write(json.dumps(pet))
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
           self.response.out.write(json.dumps(profile))
        else:
            user_id = profile["id"]
            user_key = db.Key.from_path('User', user_id)

            current_user = User.get(user_key)
            current_user.age = current_user.age + 1
            current_user.put()

            savethis = Checkin( title=checkin["title"], owner=current_user, place_id=checkin["place_id"], location=db.GeoPt(checkin["lat"], checkin["lon"]) )
            savethis.put()

            self.response.out.write(json.dumps(checkin))

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
           self.response.out.write(json.dumps(profile))
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
                                          ('/pet/save', PetSaveHandler),
                                          ('/pet/load', PetLoadHandler),
                                          ('/checkin', CheckinHandler),
                                          ('/nearby', NearbyHandler)],
                                         debug=True)
    util.run_wsgi_app(application)


if __name__ == '__main__':
    main()
