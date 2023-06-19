import 'package:first_flutter_app/utils/hexcolor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:first_flutter_app/utils/hexcolor.dart';
import 'package:first_flutter_app/model/question.dart';
import 'package:first_flutter_app/model/movie.dart';

class MovieListView extends StatelessWidget {
  MovieListView({super.key});

  final List<Movie> movieList = Movie.getMovies();

  final List movies = [
    "Titanic",
    "Blade Runner",
    "Rambo",
    "The Avengers",
    "Avatar",
    "I am legend",
    "300",
    "The Wolf of Wall Street",
    "Interstellar",
    "Game of Thrones",
    "Vikings",
    "Back to the Future"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      backgroundColor: Colors.blueGrey.shade900,
      body: ListView.builder(
          itemCount: movieList.length,
          itemBuilder: (BuildContext context, int index) {
            return Stack(children: [
              movieCard(movieList[index], context),
              Positioned(
                  top: 10.0, child: movieImage(movieList[index].images[0])),
            ]);
            // return Card(
            //   color: Colors.white,
            //   elevation: 4.5,
            //   child: ListTile(
            //     leading: CircleAvatar(
            //       child: Container(
            //         width: 200,
            //         height: 200,
            //         decoration: BoxDecoration(
            //             image: DecorationImage(
            //                 image: NetworkImage(movieList[index].images[0]),
            //                 fit: BoxFit.cover),
            //             // color: Colors.blue,
            //             borderRadius: BorderRadius.circular(13.9)),
            //         child: null,
            //       ),
            //     ),
            //     trailing: Text("T"),
            //     title: Text(movieList[index].title),
            //     subtitle: Text("${movieList[0].title}"),
            //     //onTap: () => debugPrint("Movie name: ${movies[index]}"),
            //     onTap: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => MovieListViewDetails(
            //                     movieName: movieList[index].title,
            //                     movie: movieList[index],
            //                   )));
            //     },
            //   ),
            // );
          }),
    );
  }

  Widget movieCard(Movie movie, BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(left: 60.0),
        width: MediaQuery.of(context).size.width,
        height: 120.0,
        child: Card(
            color: Colors.black45,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 54.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            movie.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          "Rating: ${movie.imdbRating} / 10",
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Released: ${movie.released}",
                          style: mainTextStyle(),
                        ),
                        Text(
                          movie.runtime,
                          style: mainTextStyle(),
                        ),
                        Text(
                          movie.rated,
                          style: mainTextStyle(),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MovieListViewDetails(
                      movieName: movie.title,
                      movie: movie,
                    )));
      },
    );
  }

  TextStyle mainTextStyle() {
    return TextStyle(fontSize: 15.0, color: Colors.grey);
  }

  Widget movieImage(String imageUrl) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: NetworkImage(
                imageUrl ??
                    'https://thumbs.dreamstime.com/b/minecraft-logo-online-game-dirt-block-illustrations-concept-design-isolated-186775550.jpg',
              ),
              fit: BoxFit.cover)),
    );
  }
}

// New route
class MovieListViewDetails extends StatelessWidget {
  // MovieListViewDetails({super.key});

  final String? movieName;
  final Movie? movie;

  MovieListViewDetails({Key? key, this.movieName, this.movie})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: ListView(
        children: [MovieDetailsThumbnail(thumbnail: movie!.images[0])],
      ),
      // body: Center(
      //   child: Container(
      //     child: ElevatedButton(
      //       child: Text("Go back ${this.movie?.director}"),
      //       onPressed: () {
      //         Navigator.pop(context);
      //       },
      //     ),
      //   ),
      // ),
    );
  }
}

class MovieDetailsThumbnail extends StatelessWidget {
  final String thumbnail;

  const MovieDetailsThumbnail({Key? key, required this.thumbnail})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 190,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(thumbnail), fit: BoxFit.cover)),
            ),
            Icon(Icons.play_circle_outline, size: 100, color: Colors.white)
          ],
        ),
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0x00f5f5f5), Color(0xfff5f5f5)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          height: 80,
        )
      ],
    );
  }
}

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  int _currentQuestionIndex = 0;

  List questionBank = [
    Question.name(
        "The U.S Declaration of Independence was adopted in 1972", true),
    Question.name("The Supreme Law of the land is the Constitution", true),
    Question.name(
        "The two rights in the Declaration of Independence are:"
        "\n Life"
        "\n Pursuit of happinnes",
        true),
    Question.name("The U.S Constitution has 26 Amendments", false),
    Question.name(
        "Freedom of religion means...\nYou can practice any religion,"
        " or not practice a religion",
        true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("True Citicen"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      backgroundColor: Colors.blueGrey,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                "images/flag.png",
                width: 250,
                height: 180,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(14.4),
                    border: Border.all(
                        color: Colors.blueGrey.shade400,
                        style: BorderStyle.solid)),
                height: 120.0,
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    questionBank[_currentQuestionIndex].questionText,
                    style: TextStyle(fontSize: 16.9, color: Colors.white),
                  ),
                )),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () => _previousQuestion(),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey.shade900),
                    child: Icon(Icons.arrow_back, color: Colors.white)),
                ElevatedButton(
                    onPressed: () => _checkAnswer(true, context),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey.shade900),
                    child: Text(
                      "TRUE",
                      style: TextStyle(color: Colors.white),
                    )),
                ElevatedButton(
                    onPressed: () => _checkAnswer(false, context),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey.shade900),
                    child: Text(
                      "FALSE",
                      style: TextStyle(color: Colors.white),
                    )),
                ElevatedButton(
                    onPressed: () => _nextQuestion(),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey.shade900),
                    child: Icon(Icons.arrow_forward, color: Colors.white))
              ],
            ),
            Spacer()
          ],
        ),
      ),
    );
  }

  _checkAnswer(bool userChoice, BuildContext context) {
    if (userChoice == questionBank[_currentQuestionIndex].isCorrect) {
      // Correct answer
      debugPrint("Yes Correct!");

      final snackBar = SnackBar(
        duration: Duration(milliseconds: 500),
        content: Text("Correct answer!"),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      debugPrint("Incorrect!");
      final snackBar = SnackBar(
        duration: Duration(milliseconds: 500),
        content: Text("Wrong answer!"),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    _nextQuestion();
  }

  _nextQuestion() {
    setState(() {
      if (_currentQuestionIndex == questionBank.length - 1)
        _currentQuestionIndex = 0;
      else
        _currentQuestionIndex++;
    });
  }

  _previousQuestion() {
    setState(() {
      if (_currentQuestionIndex == 0)
        _currentQuestionIndex = questionBank.length - 1;
      else
        _currentQuestionIndex--;
    });
  }
}

class BillSplitter extends StatefulWidget {
  const BillSplitter({super.key});

  @override
  State<BillSplitter> createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {
  int _tipPercentage = 0;
  int _personCounter = 1;
  double _billAmount = 0.0;

  Color _purple = HexColor("#6908D6");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
            alignment: Alignment.center,
            color: Colors.white,
            child: ListView(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(20.5),
              children: <Widget>[
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                      color: _purple.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.0)),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Total  Per Person",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 15.0,
                              color: _purple),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "\$ ${calculateTotalPerPerson(_billAmount, _personCounter, _tipPercentage)}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 34.9,
                                color: _purple),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 20.0),
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                            color: Colors.blueGrey.shade100,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(12.0)),
                    child: Column(
                      children: [
                        // Input Bill Amount
                        TextField(
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            style: TextStyle(color: _purple),
                            decoration: InputDecoration(
                                prefixText: "Bill Amount",
                                prefixIcon: Icon(Icons.attach_money)),
                            onChanged: (String value) {
                              try {
                                _billAmount = double.parse(value);
                              } catch (exception) {
                                _billAmount = 0.0;
                              }
                            }),
                        // Split
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Split",
                              style: TextStyle(color: Colors.grey.shade700),
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (_personCounter > 1) {
                                        _personCounter--;
                                      }
                                    });
                                  },
                                  child: Container(
                                    width: 40.0,
                                    height: 40.0,
                                    margin: EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7.0),
                                      color: _purple.withOpacity(0.1),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "-",
                                        style: TextStyle(
                                            color: _purple,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17.0),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  "$_personCounter",
                                  style: TextStyle(
                                      color: _purple,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0),
                                ),
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        _personCounter++;
                                      });
                                    },
                                    child: Container(
                                        width: 40.0,
                                        height: 40.0,
                                        margin: EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                            color: _purple.withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(7.0)),
                                        child: Center(
                                          child: Text(
                                            "+",
                                            style: TextStyle(
                                                color: _purple,
                                                fontSize: 17.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )))
                              ],
                            )
                          ],
                        ),
                        // Tip
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Tip",
                              style: TextStyle(color: Colors.grey.shade700),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Text(
                                "\$ ${(calculateTotalTip(_billAmount, _personCounter, _tipPercentage)).toStringAsFixed(2)}",
                                style: TextStyle(
                                    color: _purple,
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        // Slider
                        Column(
                          children: [
                            Text(
                              "$_tipPercentage%",
                              style: TextStyle(
                                  color: _purple,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            Slider(
                                min: 0,
                                max: 100,
                                activeColor: _purple,
                                inactiveColor: Colors.grey,
                                // Limit number of choices by adding divisions to slider
                                divisions: 20,
                                value: _tipPercentage.toDouble(),
                                onChanged: (double value) {
                                  setState(() {
                                    _tipPercentage = value.round();
                                  });
                                })
                          ],
                        )
                      ],
                    ))
              ],
            )));
  }

  calculateTotalPerPerson(double billAmount, int splitBy, int tipPercentage) {
    var totalPerPerson =
        (calculateTotalTip(billAmount, splitBy, tipPercentage) + billAmount) /
            splitBy;
    return totalPerPerson.toStringAsFixed(2);
  }

  calculateTotalTip(double billAmount, int splitBy, int tipPercentage) {
    double totalTip = 0.0;
    if (billAmount < 0 || billAmount.toString().isEmpty || billAmount == null) {
      // Error cases
    } else {
      totalTip = (billAmount * tipPercentage) / 100;
    }
    return totalTip;
  }
}

class Wisdom extends StatefulWidget {
  const Wisdom({super.key});

  @override
  State<Wisdom> createState() => _WisdomState();
}

class _WisdomState extends State<Wisdom> {
  int _index = 0;
  List quotes = [
    "The future belongs to those who believe in the beauty of their dreams.",
    "The only way to do great work is to love what you do.",
    "Believe you can and you're halfway there.",
    "Success is not final, failure is not fatal: It is the courage to continue that counts",
    "Don't watch the clock; do what it does. Keep going.",
    "The only limit to our realization of tomorrow will be our doubts of today.",
    "Believe in yourself and all that you are. Know that there is something inside you that is greater than any obstacle.",
    "The future depends on what you do today.",
    "Your time is limited, don't waste it living someone else's life.",
    "The only person you are destined to become is the person you decide to be.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Center(
            child: Container(
              width: 350,
              height: 200,
              margin: EdgeInsets.all(30.0),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(14.5)),
              child: Center(
                  child: Text(quotes[_index % quotes.length],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey.shade600,
                          fontStyle: FontStyle.italic,
                          fontSize: 16.5))),
            ),
          ),
        ), // Mod will return _index unless _index > quotes.length
        Divider(
          thickness: 1.3,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: TextButton.icon(
              onPressed: _showQuote,
              style: TextButton.styleFrom(
                backgroundColor: Colors.greenAccent.shade700, // Background
                foregroundColor: Colors.black, // Icon and
              ),
              //color: Colors.greenAccent.shade700,
              icon: Icon(Icons.wb_sunny),
              label: Text(
                "Inspire me",
                style: TextStyle(fontSize: 18.8, color: Colors.white),
              )),
        ),
        Spacer() // Add space at the bottom
      ],
    )));
  }

  void _showQuote() {
    // Increment index counter by 1
    setState(() {
      _index++;
      // if (_index > quotes.length - 1) {
      //   _index = 0;
      // }
    });
  }
}

class BizCard extends StatelessWidget {
  const BizCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Biz Card'),
          centerTitle: true,
        ),
        body: Container(
            alignment: Alignment.center,
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[_getCard(), _getAvatar()],
            )));
  }

  Container _getCard() {
    return Container(
        width: 350,
        height: 200,
        margin: EdgeInsets.all(50.0),
        decoration: BoxDecoration(
            color: Colors.pinkAccent, borderRadius: BorderRadius.circular(4.5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Oscar Luciano Flores Leija",
              style: TextStyle(
                  fontSize: 20.9,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            Text("oscar.floresl@udem.edu"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(Icons.person_outline), Text("M: @pirateman")],
            )
          ],
        ));
  }

  Container _getAvatar() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
          border: Border.all(color: Colors.redAccent, width: 1.2),
          image: DecorationImage(
              image: NetworkImage("https://picsum.photos/300/300"),
              fit: BoxFit.cover)),
    );
  }
}

class ScaffoldExample extends StatelessWidget {
  const ScaffoldExample({super.key});

  _tapButton() {
    debugPrint("Tapped button");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Scaffold"),
          centerTitle: true,
          backgroundColor: Colors.amberAccent.shade700,
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.email),
                onPressed: () => debugPrint("Email tapped!")),
            IconButton(onPressed: _tapButton, icon: Icon(Icons.access_alarm)),
            TextButton(onPressed: _tapButton, child: Text("Button!"))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.lightGreen,
          child: Icon(Icons.call_missed),
          onPressed: () => debugPrint("Floating!"),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), label: 'First'),
            BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: 'Second'),
            BottomNavigationBarItem(
                icon: Icon(Icons.access_alarm), label: 'Third')
          ],
          onTap: (int index) => debugPrint("Tapped tiem $index"),
        ),
        backgroundColor: Colors.redAccent.shade100,
        body: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(),
                ElevatedButton(
                  child: const Text(
                    'Raised Button',
                  ),
                  onPressed: () => debugPrint("Raised!"),
                ),
                /*InkWell(
              onTap: _tapButton,
              child: Container(
                width: 200,
                height: 50,
                color: Colors.black,
                child: const Center(
                  child: Text(
                    'Tap me!',
                    style: TextStyle(color: Colors.white, fontSize: 40)
                  )
                )
              )
            )*/
              ],
            )));
  }
}

class CustomButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final snackBar = SnackBar(
          content: Text("Hello again"),
          backgroundColor: Colors.amberAccent.shade700,
        );
        // Different from course, see: https://docs.flutter.dev/release/breaking-changes/scaffold-messenger
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: Colors.pinkAccent, borderRadius: BorderRadius.circular(8.0)),
        child: Text('Button'),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Material(
      color: Colors.deepOrange,
      child: Center(
          child: Text(
        "Hello Flutter!",
        textDirection: TextDirection.ltr,
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 23.4,
            fontStyle: FontStyle.italic),
      )),
    );
  }
}
