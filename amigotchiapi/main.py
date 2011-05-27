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

class Pet(db.Model):
    created = db.DateTimeProperty(auto_now_add=True)
    updated = db.DateTimeProperty(auto_now=True)
    name = db.StringProperty(required=True)
    owner = db.ReferenceProperty(User)
    hunger = db.IntegerProperty()
    last_fed = db.DateTimeProperty()
    happiness = db.IntegerProperty()
    bathroom = db.IntegerProperty()
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
                        profile_url=profile["link"])
            user.put()
            self.response.out.write(json.dumps(profile))


class PetNewHandler(webapp.RequestHandler):
    def get(self):
        self.response.out.write("doesn't work here buddy")

    def post(self):

        access_token = self.request.get("access_token")
        pet_name = self.request.get("name")

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
            pet = Pet( name=pet_name, owner=current_user, last_fed = datetime.datetime.now(), last_bathroom = datetime.datetime.now())
            pet.put()
            self.response.out.write(json.dumps(profile))


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
            results = q.fetch(5)
            for checkin in results:
               nearby.append(dict(lat=checkin.location.lat,lon=checkin.location.lon, title=checkin.title, owner=checkin.owner.name))
            self.response.out.write(json.dumps(nearby))

def main():
    application = webapp.WSGIApplication([('/', MainHandler),
                                          ('/user/login', UserLoginHandler),
                                          ('/pet/new', PetNewHandler),
                                          ('/checkin', CheckinHandler),
                                          ('/nearby', NearbyHandler)],
                                         debug=True)
    util.run_wsgi_app(application)


if __name__ == '__main__':
    main()
