
import 'package:flutter/material.dart';

enum awardTrigger {
  startApp,
  characterSelected,
  firstHour,
  fiveCorrectAnswers,
  tenCorrectAnswers,
  twentyCorrectAnswers,
  fiftyCorrectAnswers,
  sevenDays,
  tenOutOfTen,
  firstQuizz,
  threeDays,
  sundayQuizz,
  hundredCorrectAnswers,
  twoHundredCorrectAnswers

}

List<Map<String, dynamic>> locations = [

  {
    "id": "orchard",
    "name": "The Orchard",
    "image": "orchard.png",
    "strap_line": "The orchard is where Old Major is buried and from where the pigs take the apples for themselves."
  },

  {
    "id": "small_paddock",
    "name": "Small Paddock",
    "image": "small_paddock.png",
    "strap_line": "The small paddock, which was originally set aside for the animals’ retirement, in the end was planted with barley for the pigs."
  },

  {
    "id": "farmhouse_garden",
    "name": "The Garden",
    "image": "farmhouse_garden.png",
    "strap_line": "The farmhouse garden is where the flag is raised, the gun is fired on special days, and where the animals file passed old major’s skull."
  },

  {
    "id": "yard",
    "name": "The Yard",
    "image": "yard.png",
    "strap_line": "The farmhouse and other buildings all arranged around the yard. The yard is the location of the Battle of the Cowshed"
  },

  {
    "id": "cowshed",
    "name": "The Cowshed",
    "image": "cowshed.png",
    "strap_line": "The cowshed is where the animals hide at the beginning of the Battle of the Cowshed, hence the name of the battle."
  },

  {
    "id": "hen_house",
    "name": "Hen House",
    "image": "orchard.png",
    "strap_line": "The hen house is where the hens’ protest takes place. They refuse to give 400 eggs a week to be sold at market"
  },

  {
    "id": "windmill",
    "name": "The Windmill",
    "image": "windmill.png",
    "strap_line": "The windmill represents industry and technology. It shows how hard the animals work, having to adapt human equipment to their own needs and having to build the windmill on top of their other tasks."
  },

  {
    "id": "store_shed",
    "name": "The Store Shed",
    "image": "store_shed.png",
    "strap_line": "The cows break down the door of the store shed when the animals haven’t been fed for two days."
  },

  {
    "id": "foxwood_farm",
    "name": "Foxwood Farm",
    "image": "foxwood_farm.png",
    "strap_line": "Foxwood Farm is one of the neighbouring farms. It’s run by Pilkington and represents the British Empire. It’s large, old-fashioned and in a bad condition due to neglect."
  },

  {
    "id": "pinchfield_farm",
    "name": "Pinchfield Farm",
    "image": "pinchfield_farm.png",
    "strap_line": "Pinchfield Farm one of the neighbouring farms is run by Frederick and represents Germany. Pinchfield is small and well-run."
  },


  {
    "id": "barn",
    "name": "The Barn",
    "image": "barn.png",
    "strap_line": "The barn represents the animals’ ideal world where animals are not controlled by man. It is where Old Major made his speech."
  },

  {
    "id": "farmhouse",
    "name": "The Farmhouse",
    "image": "farmhouse.png",
    "strap_line": "The farmhouse represents how the ruling class lived in luxury. It shows the gulf between the animals lives and that of Jones. It also shows the power relationship between the pigs and the other animals."
  },

  {
    "id": "red_lion_inn",
    "name": "Red Lion Inn",
    "image": "pinchfield_farm.png",
    "strap_line": "The red lion inn is where Jones stays when he is driven out of Animal farm. The farmers meet here regularly to discuss Animal Farm."
  },
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
    "color": Colors.brown,
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
    "All animals are equal.",
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
    "Oooh Sugarcandy Mountain",
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
    "color": Colors.deepPurpleAccent,
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
    "A toast! To the prosperity of Animal Farm!",
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

List<Map<String, dynamic>> awardsData = [
  {
    //When the student opens the app
    "id": awardTrigger.startApp,
    "achievement": "Began Study",
    "image": "startApp",
    "name": "George Orwell Award.",
    "description":
    "George Orwell wrote Animal Farm because he felt he needed to say something about the political climate in which he was living. This award recognises desire to learn."
  },
  {

    "id": awardTrigger.characterSelected,
    "image": "characterSelected",
    "name": "Mollie Award",
    "achievement": "Character Selected",
    "description": "Mollie is a vain and shallow horse, obsessed with how she looks. This award recognises those who take time to choose how they look."
  }
  ,
  {

    "id": awardTrigger.firstHour,
    "image": "firstHour",
    "name": "Boxer Award",
    "achievement": "1 Hour's Work",
    "description": "Boxer is a loyal supporter of the revolution and the hardest worker on the farm. This award recognises hard work."
  },
  {

    "id": awardTrigger.fiveCorrectAnswers,
    "image": "fiveCorrectAnswers",
    "name": "Expulsion of Jones Award",
    "achievement": "5 Correct Answers",
    "description": "The animals drive Jones off the farm after he forgot to feed them as he was drunk. This award recognises ambition."
  }
  ,
  {

    "id": awardTrigger.tenCorrectAnswers,
    "image": "tenCorrectAnswers",
    "name": "Animalism Award",
    "achievement": "10 Correct Answers",
    "description": "The pigs create Animalism from Old Major's speech. It represents communism. This award recognises progress."
  }
  ,
  {

    "id": awardTrigger.twentyCorrectAnswers,
    "image": "twentyCorrectAnswers",
    "name": "Russian Revolution Award",
    "achievement": "20 Correct Answers",
    "description": "Animal Farm is an allegory for the Russian Revolution. This award recognises uprising through knowledge."
  },
  {

    "id": awardTrigger.fiftyCorrectAnswers,
    "image": "fiftyCorrectAnswers",
    "name": "Animal Farm Award",
    "achievement": "50 Correct Answers",
    "description": "Manor Farm is renamed Animal Farm after the revolution. This award recognises transformation."
  },
  {

    "id": awardTrigger.sevenDays,
    "image": "sevenDays",
    "name": "Seven Commandments Award",
    "achievement": "7 days of revision",
    "description": "Snowball, Napoleon and Squealer turned Old Major's ideas into the seven commandments. This award recognises commitment."
  }
  ,
  {

    "id": awardTrigger.tenOutOfTen,
    "image": "tenOutOfTen",
    "name": "Milk and Apples Award",
    "achievement": "answered 10/10 correctly",
    "description": "The pigs take the milk and apples because they are the most intelligent and the milk and apples helps with their intelligence. This award recognises intelligence."
  }
  ,
  {

    "id": awardTrigger.firstQuizz,
    "image": "firstQuizz",
    "name": "Battle of the Cowshed Award",
    "achievement": "completed a quiz",
    "description": "The humans, led by Mr Jones, attempted to take the farm back by force. The animals were waiting for them and chased them out. This award recognises forsight."
  }
  ,
  {

    "id": awardTrigger.threeDays,
    "image": "threeDays",
    "name": "Windmill Award",
    "achievement": "3 days of revision",
    "description": "Snowball designed the windmill because he believed it would increase productivity, ultimately leading to a three-day week. This award recognises productivity."
  },
  {

    "id": awardTrigger.sundayQuizz,
    "image": "sundayQuizz",
    "name": "Work Increased Award",
    "achievement": "revising on a Sunday",
    "description": "Napoleon introduces work on Sunday afternoons. He says it’s voluntary but rations are halved if they refuse. This award recognises increased work."
  },
  {

    "id": awardTrigger.hundredCorrectAnswers,
    "image": "hundredCorrectAnswers",
    "name": "Hens Rebel Award",
    "achievement": "100 correct answers",
    "description": "Napoleon demanded the hens gave up all their eggs. The Hens rebelled by laying the eggs from the rafters so they all smashed on the floor. This award recognises audacity."
  }
  ,
  {

    "id": awardTrigger.hundredCorrectAnswers,
    "image": "hundredFiftyCorrectAnswers",
    "name": "Father of all Animals",
    "achievement": "150 correct answers",
    "description": "Father of all Animals is one of the names the pigs invented for Napoleon. This award recognises mastery."
  }
  ,
  {

    "id": awardTrigger.twoHundredCorrectAnswers,
    "image": "twoHundredCorrectAnswers",
    "name": "Animal Hero, First Class",
    "achievement": "200 correct answers",
    "description": "Snowball and Boxer receive this medal for their efforts in the Battle of the Cowshed. This award recognises effort & success!"
  }
];

