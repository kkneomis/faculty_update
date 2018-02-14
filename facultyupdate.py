import os
import json
from flask import Flask, render_template, url_for, redirect, request, flash, session, jsonify
from pymongo import MongoClient
import json
from mongoengine import *
import datetime


app = Flask(__name__)
app.debug = True
app.secret_key = "not so super secret key"
my_dir = os.path.dirname(__file__)
data_path = os.path.join(my_dir, 'fdata.json')
data_out_path = os.path.join(my_dir, 'fdata2.json')

profs = {}
fac_list = []


def load_file(file_path):
    '''open the json file'''
    with open(file_path, mode='r') as f:
        people = json.load(f)['people']


    for person in people:
        profs[person['id']] = person
        fac_list.append(person)

    #print json.dumps(profs, indent=4, separators=(',', ': '))
    return "Created professors"

@app.route('/<id>')
def start(id):
    if id not in profs.keys():
        print "This professor doesnt exist"
        return redirect(url_for('new'))

    try:
        prof = profs[id]
    except:
        print "did not find prof", id
        prof = ""

    return render_template('index.html', prof=prof, people=fac_list)


@app.route('/new')
def new():
    prof = {}
    return render_template('index.html', prof=prof, people=fac_list)


@app.route('/update', methods=['POST'])
def update():
    try:
        id = request.form['id']
        prof = {}
        complex_fields = ['selected_research',
                          'areas_of_expertise',
                          'courses_taught',
                          'education',
                          'awards']

        for key, value in request.form.iteritems():
            if key in complex_fields:
                prof[key] = value.rstrip('\r').split('\r\n')
            else:
                prof[key] = value

        profs[id] = prof
        save(data_path, profs)
    except:
        print "something went wrong in rebuilding the dictionary for update"
        raise

    return redirect(url_for('start', id=id))



def save(path, data):
    with open(path, "w") as f:
      data = {"people": data.values()}
      f.write(json.dumps(data, indent=4,sort_keys=True,  separators=(',', ': ')))

if __name__ == '__main__':
    load_file(data_path)
    app.run()
