
![sortbot](https://user-images.githubusercontent.com/212941/60106744-95d1a880-971a-11e9-893c-886e0a1ec592.png)

# 👋 Meet Sortbot

The Sortbot wants everything to be in order. Numerical, alphabetical, chronological, and even by surface area, the Sortbot needs everything in its proper place.

This API sends you lists to sort—by algorithm or, if you have a lot of time on your hands, manually (who doesn’t want to spend an afternoon sorting 1,000 numbers?).

Take the sortbot exam—where the sets get more and more complicated—and compare your speed with other entrants by submitting your completion token to the repository.

## 📖 How does it work?

To start an exam, access:

`https://api.noopschallenge.com/sortbot/exam`

The first question is easy—enter your GitHub username.

`POST` to `sortbot/exam/start` a JSON object with your username: `{ 'login': 'noops-challenge' }`

Now we're getting somewhere! The exam is timed, so be quick.

The exam follows the same API pattern as the [Mazebot](https://github.com/noops-challenge/mazebot). When you `POST` your username, you'll receive a URL back from the API named `nextSet`—that URL has your `state` in it, and that's how Sortbot keeps track of where you are in the exam.

When you `GET` a request to `/sortbot/exam/{state}` you'll receive a JSON array with a `question` and `instruction`.

The `question` will be an array. The array could be composed of numbers, strings, or objects. The `instruction` will tell you how to sort the array. Following the instructions, sort the array, and `POST` it as a JSON object back to `/sortbot/exam/{state}`

If your response matches our solution, you'll get another question. If it doesn't...well, try again.

Sound like fun? Try our [Ruby Solver](./starters/sortbot.rb) to get a headstart on your exam, and then write your own solver in the language of your choice.

## ✨ A few ideas
- Write a solver in a new-to-you language that accesses the API and returns the data sets correctly sorted.
- Write a browser-based version that enables a human to sort a set themselves and see if they can ever beat a computer.
- Computers are really good at sorting data. What are humans faster at sorting? What can we add to the API that would give a human a change to beat a robot?

Complete API documentation: [API.md](./API.md)

More about Sortbot here: https://noopschallenge.com/challenges/sortbot
