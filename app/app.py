from flask import Flask, render_template
import random
app = Flask(__name__)

# list of cat images
images = [
  "https://media1.giphy.com/media/BzyTuYCmvSORqs1ABM/giphy.gif?cid=ecf05e47a61pohrnxvkjt8ax30omfxqbla893upt6n822900&rid=giphy.gif&ct=g"
  "https://media1.giphy.com/media/ICOgUNjpvO0PC/giphy.gif?cid=ecf05e47a61pohrnxvkjt8ax30omfxqbla893upt6n822900&rid=giphy.gif&ct=g"
  "https://media0.giphy.com/media/MDJ9IbxxvDUQM/giphy.gif?cid=ecf05e47a61pohrnxvkjt8ax30omfxqbla893upt6n822900&rid=giphy.gif&ct=g"
  "https://media0.giphy.com/media/JIX9t2j0ZTN9S/giphy.gif?cid=ecf05e47a61pohrnxvkjt8ax30omfxqbla893upt6n822900&rid=giphy.gif&ct=g"
  "https://media.tenor.com/zrpyKEyxZGwAAAAd/fat-cat-laser-eyes.gif"
]
@app.route('/')
def index():
  url = random.choice(images)
  return render_template('index.html', url=url)

if __name__ == "__main__":
   app.run(host="0.0.0.0")
