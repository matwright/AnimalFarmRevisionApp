import 'dart:math';

import 'package:animal_farm/src/models/character.dart';
import 'package:flutter/material.dart';

List<Map<String, dynamic>> rewards = [
  {
    //When the student opens the app
    "id": "startApp",
    "image": "startApp.png",
    "name": "George Orwell Award.",
    "description":
        "George Orwell wrote Animal Farm because he felt he needed to say something about the political climate in which he was living. This award recognises desire."
  },
  {
    
    "id": "characterSelected",
    "image": "characterSelected.png",
    "name": "Mollie Award",
    "achievement":"Character Selected",
    "description": "Mollie is a vain and shallow horse, obsessed with how she looks. This award recognises those who take time to choose how they look."
  }
  ,
  {
    
    "id": "firstHour",
    "image": "firstHour.png",
    "name": "Boxer Award",
    "achievement":"1 Hour's Work",
    "description": "Boxer is a loyal supporter of the revolution and the hardest worker on the farm. This award recognises hard work."
  },
  {
    
    "id": "fiveCorrectAnswers",
    "image": "fiveCorrectAnswers.png",
    "name": "Expulsion of Jones Award",
    "achievement":"5 Correct Answers",
    "description": "The animals drive Jones off the farm after he forgot to feed them as he was drunk. This award recognises ambition."
  }
  ,
  {
    
    "id": "tenCorrectAnswers",
    "image": "tenCorrectAnswers.png",
    "name": "Animalism Award",
    "achievement":"10 Correct Answers",
    "description": "The pigs create Animalism from Old Major's speech. It represents communism. This award recognises progress."
  }
  ,
  {
    
    "id": "twentyCorrectAnswers",
    "image": "twentyCorrectAnswers.png",
    "name": "Russian Revolution Award",
    "achievement":"20 Correct Answers",
    "description": "Animal Farm is an allegory for the Russian Revolution. This award recognises uprising through knowledge."
  },
  {
    
    "id": "fiftyCorrectAnswers",
    "image": "fiftyCorrectAnswers.png",
    "name": "Animal Farm Award",
    "achievement":"50 Correct Answers",
    "description": "Manor Farm is renamed Animal Farm after the revolution. This award recognises transformation."
  },
  {
    
    "id": "sevenDays",
    "image": "sevenDays.png",
    "name": "Seven Commandments Award",
    "achievement":"7 days of revision",
    "description": "Snowball, Napoleon and Squealer turned Old Major's ideas into the seven commandments. This award recognises commitment."
  }
  ,
  {
    
    "id": "tenOutOfTen",
    "image": "tenOutOfTen.png",
    "name": "Milk and Apples Award",
    "achievement":"answered 10/10 correctly",
    "description": "The pigs take the milk and apples because they are the most intelligent and the milk and apples helps with their intelligence. This award recognises intelligence."
  }
  ,
  {
    
    "id": "firstQuizz",
    "image": "firstQuizz.png",
    "name": "Battle of the Cowshed Award",
    "achievement":"completed a quiz",
    "description": "The humans, led by Mr Jones, attempted to take the farm back by force. The animals were waiting for them and chased them out. This award recognises forsight."
  }
  ,
  {
    
    "id": "threeDays",
    "image": "threeDays.png",
    "name": "Windmill Award",
    "achievement":"3 days of revision",
    "description": "Snowball designed the windmill because he believed it would increase productivity, ultimately leading to a three-day week. This award recognises productivity."
  }  ,
  {

    "id": "sundayQuizz",
    "image": "sundayQuizz.png",
    "name": "Work Increased Award",
    "achievement":"revising on a Sunday",
    "description": "Napoleon introduces work on Sunday afternoons. He says it’s voluntary but rations are halved if they refuse. This award recognises increased work."
  } ,
  {

    "id": "hundredCorrectAnswers",
    "image": "hundredCorrectAnswers.png",
    "name": "Hens Rebel Award",
    "achievement":"100 correct answers",
    "description": "Napoleon demanded the hens gave up all their eggs. The Hens rebelled by laying the eggs from the rafters so they all smashed on the floor. This award recognises audacity."
  }
  ,
  {

    "id": "hundredCorrectAnswers",
    "image": "hundredCorrectAnswers.png",
    "name": "4 Legs good, 2 Legs Better Award",
    "achievement":"100 correct answers",
    "description": "The pigs were walking on two legs at this point, so the sheep were taught to chant “four legs good, two legs better”. This award recognises audacity."
  }
  ,
  {

    "id": "hundredCorrectAnswers",
    "image": "hundredCorrectAnswers.png",
    "name": "Animalism is Over Award",
    "achievement":"100 correct answers",
    "description": "Napoleon eventually tells the animals that Animalism means working harder and living frugally. This award recognises audacity."
  }
];

List<Map<String, dynamic>> characters = [
  {
    "id": "napoleon",
    "name": "Napoleon",
    "avatar": "napoleon.png",
    "bio":
        "Napoleon is the villain. He is cunning, corrupt & selfish. He uses his loyal attack dogs to intimidate the other animals & control the farm. By the end of the book, Napoleon has become Jones. Napoleon represents Joseph Stalin.",
    "strap_line": "Some animals are more equal than others",
    "color": Color(0xffd63737),
    "text_color": Color(0xffeeeeee)
  },
  {
    "id": "snowball",
    "name": "Snowball",
    "avatar": "snowball.png",
    "bio":
        "Snowball is smart & idealistic. He believes in the equality of all animals & uses his intelligence to share the ideals of Animalism with all the animals. He can be dishonest, but he is a brave & strong leader. Eventually Snowball is undermined by Napoleon as he feels threatened by him. Napoleon has Snowball exiled from the farm. Snowball represents Leon Trotsky.",
    "strap_line": "Four legs good, two legs bad",
    "color": Color(0xFF00796B),
    "text_color": Color(0xffeeeeee)
  },
  {
    "id": "boxer",
    "name": "Boxer",
    "avatar": "boxer.png",
    "bio":
        "Boxer is a cart-horse - the hardest working animal on the farm. He is incredibly strong & brave. Boxer believes any problem can be solved by working harder. He is not very bright & is easily manipulated by the pigs. He trusts them to make all his decisions. Boxer is best friends with Benjamin. Boxer represents the peasant workers.",
    "strap_line": "Napoleon is always right!",
    "color": Color(0x99795548),
    "text_color": Color(0xffeeeeee)
  },
  {
    "id": "old_major",
    "name": "Old Major",
    "avatar": "old_major.png",
    "bio":
        "Old Major is the oldest & wisest pig on the farm. He inspires the rebellion after sharing a dream he had a few days before he died. His vision is used as the basis for Animalism. He is respected by all the other animals. Old Major represents Karl Marx.",
    "strap_line": "The wisest pig on the farm",
    "color": Color(0xFF4A148C),
    "text_color": Color(0xffeeeeee)
  },
  {
    "id": "squealer",
    "name": "Squealer",
    "avatar": "squealer.png",
    "bio":
        "Squealer uses propaganda to glorify Napoleon & blame Snowball. He is persuasive, manipulative & deceitful.Squealer controls the animals with lies through his clever use of language. He rewrites history & turns the animals against Snowball. Squealer represents the use of communist propaganda in Russia.",
    "strap_line":
        "No one believes more firmly than Comrade Napoleon that all animals are equal.",
    "color": Color(0xFFFFC107),
    "text_color": Color(0xff333333)
  },
  {
    "id": "moses",
    "name": "Moses",
    "avatar": "moses.png",
    "bio":
        "Moses the raven is jones’ pet. The animals don’t like him as he lies & does no work. Moses tells stories about Sugarcandy Mountain, which he describes as a paradise where the animals go after they die. The pigs decide it’s useful to have a raven convincing the oppressed labourers that paradise is waiting for them if they keep working hard enough. Moses represents the Russian Orthodox Church.",
    "strap_line":
        "…on the other side of that dark cloud…lies Sugarcandy Mountain",
    "color": Color(0xFF616161),
    "text_color": Color(0xffeeeeee)
  },
  {
    "id": "farmer_jones",
    "name": "Farmer Jones",
    "avatar": "farmer_jones.png",
    "bio":
        "Jones is the owner of Manor Farm. He is a drunk & lazy. He doesn’t care about the animals or the farm. The animals were able to have their meeting when he forgot to lock them up properly. He tries to reclaim his farm after the rebellion, but the animals defeat him. Jones represents Tsar Nicholas II.",
    "strap_line": "A lazy drunk.",
    "color": Color(0xFFF9A825),
    "text_color": Color(0xff333333)
  },
  {
    "id": "benjamin",
    "name": "Benjamin",
    "avatar": "benjamin.png",
    "bio":
        "Benjamin is very intelligent, grumpy & cynical. He is the only animal other than the pigs who can read fluently. He is the oldest animal on the farm. He understands what’s going on but doesn’t do anything about it.   Benjamin is represents the intellectual Russians.",
    "strap_line":
        "Donkeys live a long time. None of you has ever seen a dead donkey",
    "color": Color(0xfffcaa89),
    "text_color": Color(0xff000000)
  },
  {
    "id": "clover",
    "name": "Clover",
    "avatar": "clover.png",
    "bio":
        "Clover is the mother figure of the farm. When the animals are frightened, she looks after them. She is a loyal follower of Animalism. A kind & caring horse that starts to see the faults in Napoleon’s rule but assumes she has misremembered the commandments. Clover represents the workers.",
    "strap_line": "A kind & caring horse",
    "color": Color(0xFFFCE4EC),
    "text_color": Color(0xff333333)
  },
  {
    "id": "mollie",
    "name": "Mollie",
    "avatar": "mollie.png",
    "bio":
        "Mollie is vain, lazy & cowardly. She hides during the Battle of the Cowshed & has no interest in the rebellion. She likes ribbons & sugar, however these are banned in Animalism. Mollie represents the upper-class Russians.",
    "strap_line": "Will there still be sugar after the Rebellion?",
    "color": Color(0xFFFF59D),
    "text_color": Color(0xffeeeeee)
  },
  {
    "id": "frederick",
    "name": "Frederick",
    "avatar": "frederick.png",
    "bio":
        "Frederick owns Pinchfield one of the neighbouring farms. He is a cutthroat businessman who hopes to turn the rebellion at Animal Farm to his advantage. Frederick cheats the animals out of their timber by paying with fake banknotes. Frederick represents Hitler & Nazi Germany.",
    "strap_line": "Frederick is perpetually involved in lawsuits",
    "color": Color(0xFFB71C1C),
    "text_color": Color(0xffeeeeee)
  },
  {
    "id": "pilkington",
    "name": "Pilkington",
    "avatar": "pilkington.png",
    "bio":
        "Pilkington owns Foxwood, a neighbouring farm that is shabby & neglected. He prefers pursuing his hobbies than looking after his farm. Pilkington eventually becomes Napoleon’s ally. Pilkington represents the capitalist west.",
    "strap_line":
        "Gentlemen, I give you a toast: To the prosperity of Animal Farm!",
    "color": Color(0xFF66BB6A),
    "text_color": Color(0xffeeeeee)
  },
  {
    "id": "muriel",
    "name": "Muriel",
    "avatar": "muriel.png",
    "bio":
        "Muriel is a dependable goat & often worked alongside Benjamin in the construction of the windmills. She read all the changes to the commandments as they happened & reported back to the animals that couldn’t read. She represents the minority of educated working class people.",
    "strap_line": "A dependable goat",
    "color": Color(0xFF3E2723),
    "text_color": Color(0xffeeeeee)
  }
];
