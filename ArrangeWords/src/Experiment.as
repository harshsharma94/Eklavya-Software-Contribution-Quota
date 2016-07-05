package  
{
	import pie.graphicsLibrary.*;
	import pie.uiElements.*;
	/**
	 * ...
	 * @author Harsh Sharma
	 */
	public class Experiment 
	{
		//project framework handle
		private var pieHandle:PIE;
		
		//colors
		private var displayBColor:uint;
		private var displayFColor:uint;
		private var UIpanelBColor:uint;
		private var UIpanelFColor:uint;
		private var controlBColor:uint;
		private var controlFColor:uint;
		private var headingTextColor:uint;
		private var backgroundActivityColor:uint;
		private var greenColor:uint ;
		private var	yellowColor:uint ;
		private var violetColor:uint;
		private var darkPinkColor:uint ;
		private var pinkColor:uint;
		private var orangeColor:uint;
		private var redColor:uint;
		
		//Dimensional Parameters
		private var worldOriginX:Number;
		private var worldOriginY:Number;
		private var worldWidth:Number;
		private var worldHeight:Number;
		private var heightFactor:Number;
		private var widthFactor:Number;
		
		//Rectangles to hold words and make them draggable
		private var rectangle1:PIErectangle;
		private var rectangle2:PIErectangle;
		private var rectangle3:PIErectangle;
		private var rectangle4:PIErectangle;
		private var rectangle5:PIErectangle;
		private var rectangle6:PIErectangle;
		
		//PieLabels for displaying words
		private var word1:PIElabel;
		private var word2:PIElabel;
		private var word3:PIElabel;
		private var word4:PIElabel;
		private var word5:PIElabel;
		private var word6:PIElabel;
		
		//Declaring Lines
		private var line1:PIEline;
		private var line2:PIEline;
		private var line3:PIEline;
		private var line4:PIEline;
		private var line5:PIEline;
		private var line6:PIEline;
		private var line7:PIEline;
		private var line8:PIEline;
		private var line9:PIEline;
		private var line10:PIEline;
		private var line11:PIEline;
		private var line12:PIEline;
		
		//flags to find out position of Words
		private var flag1:Array;
		private var flag2:Array;
		private var flag3:Array;
		private var flag4:Array;
		private var flag5:Array;
		private var flag6:Array;
		
		//Instruction
		private var instr:PIElabel;
		
		//Array for Holding Words
		private var wordArray:Array;
		private var shuffledArray:Array;
		
		//Random Word Implementation
		private var random:Number;
		private var max:Number;
		private var min:Number;
		
		//Button
		private var doneButton:PIEbutton;
		private var nextButton:PIEbutton;
		
		//Holding Current set of Words for sorting
		private var sortArray:Array;
		
		//Flags for checking that the words are placed in the correct box
		private var correctBox1:Number;
		private var correctBox2:Number;
		private var correctBox3:Number;
		private var correctBox4:Number;
		private var correctBox5:Number;
		private var correctBox6:Number;
		
		//Result PIElabel
		private var correctResult:PIElabel;
		private var incorrectResult:PIElabel;
		private var correctAns:PIElabel;
		
		private var pointX1:Number;
		private var pointX2:Number;
		private var pointX3:Number;
		private var pointX4:Number;
		private var pointX5:Number;
		
		private var pointY1:Number;
		private var pointY2:Number;
		
		public function Experiment(pie:PIE) 
		{
			pieHandle = pie;
			
			pieHandle.PIEsetDrawingArea(1.0, 1.0);
			pieHandle.PIEsetUIpanelInvisible();
			
			this.setColor();
			this.resetWorld();
			//used for Choosing a random word from shuffled array
			min = 0;
			max = 93;
			random = (Math.floor(Math.random() * (1 + max - min)) + min);
			if (random % 2 != 0)
				random = random - 1;
			
			shuffledArray = [];
			wordArray = new Array("Main", "Void", "Tool", "Help", "View", "Edit", "Jazz", "Buzz", "Fuzz", "Fizz",
								"Quiz", "Line", "File", "Save", "Jack", "Jump", "Maze", "Joke", "Leaf", "Bone",
								"Left", "Earn", "Lady", "High", "Vain", "Type", "Spot", "Bath", "Quit", "Hero",
								"Horn", "Dive", "Dice", "Life", "Thin", "Lawn", "Join", "Fire", "Fact", "Mint",
								"Disk", "Bean", "Seat", "Keys", "Nail", "Lamp", "Salt", "Poem", "Pump", "Tire",
								"Card", "Past", "Foot", "Shoe", "Maps", "Rose", "Fork", "Cold", "Nose", "Bird",
								"Copy", "Ship", "Goat", "Bear", "Line", "Wolf", "Pain", "Lane", "Lace", "Wash",
								"Cape", "Hair", "Cook", "Chat", "Coat", "Pray", "Sing", "Rain", "Road", "Rise",
								"Name", "Apex", "Ache", "Hand", "Deer", "Flag", "Tent", "Snow", "Hate", "Gate",
								"Cars", "Make", "Boat", "Loop", "Lung", "Dove", "Kind", "Girl", "Kids", "Neck");
			
			//Shuffling the array
			while (wordArray.length > 0)
			{
				shuffledArray.push(wordArray.splice(Math.round(Math.random() * (wordArray.length - 1)), 1)[0]);
			}
			
			this.setupRects();
			this.setupLabels(shuffledArray[random++], shuffledArray[random++], shuffledArray[random++],
				shuffledArray[random++], shuffledArray[random++], shuffledArray[random++]);
			this.setupLines();
			
			pieHandle.showExperimentName("Arrange Words");
			pieHandle.showDeveloperName("Harsh Sharma");
			
		}
		
		public function resetWorld():void
		{
			worldWidth = pieHandle.experimentDisplay.width;
			worldHeight = pieHandle.experimentDisplay.height;
			
			worldOriginX = 0;               /* Origin at Uppermost Left Corner */
			worldOriginY = 0;
			pieHandle.PIEsetApplicationBoundaries(worldOriginX, worldOriginY, worldWidth, worldHeight);
			
			heightFactor = worldHeight / 6;
			widthFactor = worldWidth / 6;
			
			doneButton = new PIEbutton(pieHandle, "Check");
			doneButton.setActualSize(worldWidth / 12, worldHeight / 12);
			doneButton.addClickListener(handleDone);
			doneButton.setVisible(true);
            pieHandle.addChild(doneButton);
			doneButton.x = widthFactor/2;
			doneButton.y = worldHeight / 3 - (0.05)*heightFactor;
			
			nextButton = new PIEbutton(pieHandle, "Next");
			nextButton.setActualSize(worldWidth / 12, worldHeight / 12);
			nextButton.addClickListener(handleNext);
			nextButton.setVisible(true);
            pieHandle.addChild(nextButton);
			nextButton.x = 	widthFactor/2;
			nextButton.y = (worldHeight / 3) + (0.5)*heightFactor;
			
			flag1 = new Array(0, 0, 0, 0, 0, 0);
			flag2 = new Array(0, 0, 0, 0, 0, 0);
			flag3 = new Array(0, 0, 0, 0, 0, 0);
			flag4 = new Array(0, 0, 0, 0, 0, 0);
			flag5 = new Array(0, 0, 0, 0, 0, 0);
			flag6 = new Array(0, 0, 0, 0, 0, 0);
			
			correctBox1 = 0;
			correctBox2 = 0;
			correctBox3 = 0;
			correctBox4 = 0;
			correctBox5 = 0;
			correctBox6 = 0;
		}
		
		public function setColor():void
		{
			displayBColor = 0XFFFF44;
			displayFColor = 0XAA0000;
			UIpanelBColor = 0X00DD00;
			UIpanelFColor = 0XCCCCCC;
			controlBColor = 0X8888DD;
			controlFColor = 0XCCCCCC;
			headingTextColor = 0XBFBFBF;
			backgroundActivityColor = 0X0D0D0D;
			greenColor = 0X55961E;
			yellowColor = 0XE1DC28;
			violetColor = 0X8800C2;
			darkPinkColor = 0X990033;
			pinkColor = 0XAB0962;
			orangeColor = 0XFF7E0B;
			redColor = 0XFF0000;
			
			pieHandle.PIEsetDisplayColors(backgroundActivityColor, displayFColor);
			pieHandle.PIEsetUIpanelColors(UIpanelBColor, UIpanelFColor);
		}
		
		public function handleDone():void
		{
			sortArray.sort();
			
			checkFirstWord();
			checkSecondWord();
			checkThirdWord();
			checkFourthWord();
			checkFifthWord();
			checkSixthWord();
			
			if (correctBox1 == 1 && correctBox2==1 && correctBox3==1 && correctBox4==1 && correctBox5==1 && correctBox6==1)
			{
				callCorrect();
			}
			else
			{
				callIncorrect();
			}
		}
		
		public function handleNext():void
		{
			word1.text = "";
			word1.background = false;
			word2.text = "";
			word2.background = false;
			word3.text = "";
			word3.background = false;
			word4.text = "";
			word4.background = false;
			word5.text = "";
			word5.background = false;
			word6.text = "";
			word6.background = false;
			
			if (correctResult)
			{
				correctResult.text = "";
				correctResult.background = false;
			}
			
			if (incorrectResult)
			{
				incorrectResult.text = "";
				incorrectResult.background = false;
			}
			if (correctAns)
			{
				correctAns.text = "";
				correctAns.background = false;
			}
			
			min = 0;
			max = 93;
			random = (Math.floor(Math.random() * (1 + max - min)) + min);
			if (random % 2 != 0)
				random = random - 1;
			
			setupRects();
			setupLabels(shuffledArray[random++], shuffledArray[random++], shuffledArray[random++],
				shuffledArray[random++], shuffledArray[random++], shuffledArray[random++]);
				
			flag1 = new Array(0, 0, 0, 0, 0, 0);
			flag2 = new Array(0, 0, 0, 0, 0, 0);
			flag3 = new Array(0, 0, 0, 0, 0, 0);
			flag4 = new Array(0, 0, 0, 0, 0, 0);
			flag5 = new Array(0, 0, 0, 0, 0, 0);
			flag6 = new Array(0, 0, 0, 0, 0, 0);
			
			correctBox1 = 0;
			correctBox2 = 0;
			correctBox3 = 0;
			correctBox4 = 0;
			correctBox5 = 0;
			correctBox6 = 0;
			
		}
		
		public function callCorrect():void
		{
			if (correctResult)
			{
				correctResult.text = "";
				correctResult.background = false;
			}
			if (incorrectResult)
			{
				incorrectResult.text = "";
				incorrectResult.background = false;
			}
			if (correctAns)
			{
				correctAns.text = "";
				correctAns.background = false;
			}
			correctResult = new PIElabel(pieHandle, "Correct", worldWidth / 10, greenColor, headingTextColor);
			correctResult.x = 2*worldWidth/6;
			correctResult.y = worldHeight/6;
			pieHandle.addDisplayChild(correctResult);
		}
		
		public function callIncorrect():void
		{
			if (correctResult)
			{
				correctResult.text = "";
				correctResult.background = false;
			}
			if (incorrectResult)
			{
				incorrectResult.text = "";
				incorrectResult.background = false;
			}
			if (correctAns)
			{
				correctAns.text = "";
				correctAns.background = false;
			}
			incorrectResult = new PIElabel(pieHandle ,"Incorrect", worldWidth / 10, redColor, headingTextColor);
			incorrectResult.x = 2*worldWidth/6;
			incorrectResult.y = worldHeight/6;
			pieHandle.addDisplayChild(incorrectResult);
			
			correctAns = new PIElabel(pieHandle, "Correct Order: " + sortArray[0]+"  " + sortArray[1]+"  " + sortArray[2]+"  " + sortArray[3] 
					+"  "+ sortArray[4]+"  " + sortArray[5], worldWidth / 25, backgroundActivityColor, headingTextColor);
			correctAns.background = false;
			correctAns.x = 0;
			//correctAns.y = 3 * worldHeight / 6;
			correctAns.y = 8 * worldHeight / 9;
			pieHandle.addDisplayChild(correctAns);
		}
		
		public function checkFirstWord():void
		{
			//Checking the first Word with sorted array
			if (flag1[0] == 1 && (word1.text == sortArray[0]))
			{
				correctBox1 = 1;
			}
			else if (flag2[0] == 1 && (word2.text == sortArray[0]))
			{
				correctBox1 = 1;
			}
			else if (flag3[0] == 1 && (word3.text == sortArray[0]))
			{
				correctBox1 = 1;
			}
			else if (flag4[0] == 1 && (word4.text == sortArray[0]))
			{
				correctBox1 = 1;
			}
			else if (flag5[0] == 1 && (word5.text == sortArray[0]))
			{
				correctBox1 = 1;
			}
			else if (flag6[0] == 1 && (word6.text == sortArray[0]))
			{
				correctBox1 = 1;
			}
			
		}
		
		public function checkSecondWord():void
		{
			//Checking the Second Word with sorted array
			if (flag1[1] == 1 && (word1.text == sortArray[1]))
			{
				correctBox2 = 1;
			}
			else if (flag2[1] == 1 && (word2.text == sortArray[1]))
			{
				correctBox2 = 1;
			}
			else if (flag3[1] == 1 && (word3.text == sortArray[1]))
			{
				correctBox2 = 1;
			}
			else if (flag4[1] == 1 && (word4.text == sortArray[1]))
			{
				correctBox2 = 1;
			}
			else if (flag5[1] == 1 && (word5.text == sortArray[1]))
			{
				correctBox2 = 1;
			}
			else if (flag6[1] == 1 && (word6.text == sortArray[1]))
			{
				correctBox2 = 1;
			}
		}
		
		public function checkThirdWord():void
		{
			//Checking the Third Word with sorted array
			if (flag1[2] == 1 && (word1.text == sortArray[2]))
			{
				correctBox3 = 1;
			}
			else if (flag2[2] == 1 && (word2.text == sortArray[2]))
			{
				correctBox3 = 1;
			}
			else if (flag3[2] == 1 && (word3.text == sortArray[2]))
			{
				correctBox3 = 1;
			}
			else if (flag4[2] == 1 && (word4.text == sortArray[2]))
			{
				correctBox3 = 1;
			}
			else if (flag5[2] == 1 && (word5.text == sortArray[2]))
			{
				correctBox3 = 1;
			}
			else if (flag6[2] == 1 && (word6.text == sortArray[2]))
			{
				correctBox3 = 1;
			}
		}
		
		public function checkFourthWord():void
		{
			//Checking the Fourth Word with sorted array
			if (flag1[3] == 1 && (word1.text == sortArray[3]))
			{
				correctBox4 = 1;
			}
			else if (flag2[3] == 1 && (word2.text == sortArray[3]))
			{
				correctBox4 = 1;
			}
			else if (flag3[3] == 1 && (word3.text == sortArray[3]))
			{
				correctBox4 = 1;
			}
			else if (flag4[3] == 1 && (word4.text == sortArray[3]))
			{
				correctBox4 = 1;
			}
			else if (flag5[3] == 1 && (word5.text == sortArray[3]))
			{
				correctBox4 = 1;
			}
			else if (flag6[3] == 1 && (word6.text == sortArray[3]))
			{
				correctBox4 = 1;
			}
			
		}
		
		public function checkFifthWord():void
		{
			//Checking the Fifth Word with sorted array
			if (flag1[4] == 1 && (word1.text == sortArray[4]))
			{
				correctBox5 = 1;
			}
			else if (flag2[4] == 1 && (word2.text == sortArray[4]))
			{
				correctBox5 = 1;
			}
			else if (flag3[4] == 1 && (word3.text == sortArray[4]))
			{
				correctBox5 = 1;
			}
			else if (flag4[4] == 1 && (word4.text == sortArray[4]))
			{
				correctBox5 = 1;
			}
			else if (flag5[4] == 1 && (word5.text == sortArray[4]))
			{
				correctBox5 = 1;
			}
			else if (flag6[4] == 1 && (word6.text == sortArray[4]))
			{
				correctBox5 = 1;
			}
			
		}
		
		public function checkSixthWord():void
		{
			//Checking the Third Word with sorted array
			if (flag1[5] == 1 && (word1.text == sortArray[5]))
			{
				correctBox6 = 1;
			}
			else if (flag2[5] == 1 && (word2.text == sortArray[5]))
			{
				correctBox6 = 1;
			}
			else if (flag3[5] == 1 && (word3.text == sortArray[5]))
			{
				correctBox6 = 1;
			}
			else if (flag4[5] == 1 && (word4.text == sortArray[5]))
			{
				correctBox6 = 1;
			}
			else if (flag5[5] == 1 && (word5.text == sortArray[5]))
			{
				correctBox6 = 1;
			}
			else if (flag6[5] == 1 && (word6.text == sortArray[5]))
			{
				correctBox6 = 1;
			}
		}
		
		public function setupLabels(w1:String, w2:String, w3:String, w4:String, w5:String, w6:String):void
		{
			sortArray = new Array(w1, w2, w3, w4, w5, w6);
			
			instr = new PIElabel(pieHandle, "Arrange four-letter words in Alphabetical order by placing them in boxes below",
				worldWidth / 36 , controlBColor, headingTextColor);
			instr.background = false;
			instr.setLabelUnderline(true);
			instr.text = "Arrange four-letter words in Alphabetical order by placing them in boxes below";
			instr.x = 0;
			pieHandle.addDisplayChild(instr);
			
			word1 = new PIElabel(pieHandle, w1,
				worldWidth / 18 , controlBColor, headingTextColor);
			word1.background = false;
			word1.x = widthFactor;
			word1.y = worldHeight / 3 - heightFactor;
			rectangle1.addChild(word1);
			
			word2 = new PIElabel(pieHandle, w2,
				worldWidth / 18, controlBColor, headingTextColor);
			word2.background = false;
			word2.x = (2 * worldWidth / 3) + widthFactor;
			word2.y = (2 * worldHeight / 3) - heightFactor;
			rectangle2.addChild(word2);
			
			word3 = new PIElabel(pieHandle, w3,
				worldWidth / 18 , controlBColor, headingTextColor);
			word3.background = false;
			word3.x = worldWidth/3 + widthFactor;
			word3.y = worldHeight / 3 - heightFactor;
			rectangle3.addChild(word3);
			
			word4 = new PIElabel(pieHandle, w4,
				worldWidth / 18, controlBColor, headingTextColor);
			word4.background = false;
			word4.x = (worldWidth/3) + widthFactor;
			word4.y = (2 * worldHeight / 3) - heightFactor;
			rectangle4.addChild(word4);
			
			word5 = new PIElabel(pieHandle, w5,
				worldWidth / 18 , controlBColor, headingTextColor);
			word5.background = false;
			word5.x = (2 * worldWidth/3) + widthFactor;
			word5.y = (worldHeight / 3) - heightFactor;
			rectangle5.addChild(word5);
			
			word6 = new PIElabel(pieHandle, w6,
				worldWidth / 18, controlBColor, headingTextColor);
			word6.background = false;
			word6.x = 0 + widthFactor;
			word6.y = (2 * worldHeight / 3) - heightFactor;
			rectangle6.addChild(word6);
		}
		
		public function setupRects():void
		{
			rectangle1 = new PIErectangle(pieHandle, worldOriginX, worldOriginY, worldWidth / 1000, worldHeight / 1000, controlFColor);	
			rectangle1.addDragAndDropListeners(aGrab1, aDrag1, aDrop1);
			pieHandle.addDisplayChild(rectangle1);
			
			rectangle2 = new PIErectangle(pieHandle, worldOriginX, worldOriginY, worldWidth / 1000, worldHeight / 1000, controlFColor);	
			rectangle2.addDragAndDropListeners(aGrab2, aDrag2, aDrop2);
			pieHandle.addDisplayChild(rectangle2);
			
			rectangle3 = new PIErectangle(pieHandle, worldOriginX, worldOriginY, worldWidth / 1000, worldHeight / 1000, controlFColor);
			rectangle3.addDragAndDropListeners(aGrab3, aDrag3, aDrop3);
			pieHandle.addDisplayChild(rectangle3);
			
			rectangle4 = new PIErectangle(pieHandle, worldOriginX, worldOriginY, worldWidth / 1000, worldHeight / 1000, controlFColor);
			rectangle4.addDragAndDropListeners(aGrab4, aDrag4, aDrop4);
			pieHandle.addDisplayChild(rectangle4);
			
			rectangle5 = new PIErectangle(pieHandle, worldOriginX, worldOriginY, worldWidth / 1000, worldHeight / 1000, controlFColor);
			rectangle5.addDragAndDropListeners(aGrab5, aDrag5, aDrop5);
			pieHandle.addDisplayChild(rectangle5);
			
			rectangle6 = new PIErectangle(pieHandle, worldOriginX, worldOriginY, worldWidth / 1000, worldHeight / 1000, controlFColor);
			rectangle6.addDragAndDropListeners(aGrab6, aDrag6, aDrop6);
			pieHandle.addDisplayChild(rectangle6);
		}
		
		public function setupLines():void
		{
			
			pointX1 = worldWidth / 6;
			pointX2 = 2 * worldWidth / 6;
			pointX3 = 3 * worldWidth / 6;
			pointX4 = 4 * worldWidth / 6;
			pointX5 = 5 * worldWidth / 6;
			
			pointY1 = 2 * worldHeight / 3;
			pointY2 = 7.3 * worldHeight / 9;
			
			line1 = new PIEline(pieHandle, 0, pointY1, pointX1, pointY1, violetColor, worldWidth / 300, worldWidth / 50);
			pieHandle.addDisplayChild(line1);
			line2 = new PIEline(pieHandle, pointX1, pointY1, pointX1, pointY2, violetColor, worldWidth / 300, worldWidth / 50);
			pieHandle.addDisplayChild(line2);
			line3 = new PIEline(pieHandle, pointX1, pointY1, pointX2, pointY1, violetColor, worldWidth / 300, worldWidth / 50);
			pieHandle.addDisplayChild(line3);
			line4 = new PIEline(pieHandle, pointX2, pointY1, pointX2, pointY2, violetColor, worldWidth / 300, worldWidth / 50);
			pieHandle.addDisplayChild(line4);
			line5 = new PIEline(pieHandle, pointX2, pointY1, pointX3, pointY1, violetColor, worldWidth / 300, worldWidth / 50);
			pieHandle.addDisplayChild(line5);
			line6 = new PIEline(pieHandle,pointX3, pointY1, pointX3, pointY2, violetColor, worldWidth / 300, worldWidth / 50);
			pieHandle.addDisplayChild(line6);
			line7 = new PIEline(pieHandle, pointX3, pointY1, pointX4, pointY1, violetColor, worldWidth / 300, worldWidth / 50);
			pieHandle.addDisplayChild(line7);
			line8 = new PIEline(pieHandle, pointX4, pointY1, pointX4, pointY2, violetColor, worldWidth / 300, worldWidth / 50);
			pieHandle.addDisplayChild(line8);
			line9 = new PIEline(pieHandle, pointX4, pointY1, pointX5, pointY1, violetColor, worldWidth / 300, worldWidth / 50);
			pieHandle.addDisplayChild(line9);
			line10 = new PIEline(pieHandle, pointX5, pointY1, pointX5, pointY2, violetColor, worldWidth / 300, worldWidth / 50);
			pieHandle.addDisplayChild(line10);
			line11 = new PIEline(pieHandle, pointX5, pointY1, worldWidth, pointY1, violetColor, worldWidth / 300, worldWidth / 50);
			pieHandle.addDisplayChild(line11);
			line12 = new PIEline(pieHandle, 0, pointY2, worldWidth, pointY2, violetColor, worldWidth / 300, worldWidth / 50);
			pieHandle.addDisplayChild(line12);
			
		}
		
		public function aDrop1(newX:Number, newY:Number, displacementX:Number, displacementY:Number):void
		{
			rectangle1.x = newX - widthFactor;
			rectangle1.y = newY - worldHeight / 3 + heightFactor;
			
			if ((newY > pointY1) && (newY < pointY2) && (newX < pointX1))
			{
				flag1[0] = 1;
			}
			else
			{
				flag1[0] = 0;
			}
			
			if ((newY > pointY1) && (newY < pointY2) && (newX < pointX2) && (newX > worldWidth / 6))
			{
				flag1[1] = 1;
			}
			else
			{
				flag1[1] = 0;
			}
			
			if ((newY > pointY1) && (newY < pointY2) && (newX > pointX2) && (newX < pointX3))
			{
				flag1[2] = 1;
			}
			else
			{
				flag1[2] = 0;
			}
			
			if ((newY > pointY1)  && (newY < pointY2) && (newX > pointX3) && (newX < pointX4))
			{
				flag1[3] = 1;
			}
			else
			{
				flag1[3] = 0;
			}
			
			if ((newY > pointY1)  && (newY < pointY2) && (newX > pointX4) && (newX < pointX5))
			{
				flag1[4] = 1;
			}
			else
			{
				flag1[4] = 0;
			}
			
			if ((newY > pointY1) && (newY < pointY2) &&  (newX > pointX5) && (newX < worldWidth))
			{
				flag1[5] = 1;
			}
			else
			{
				flag1[5] = 0;
			}
		}
		
		public function aDrag1(newX:Number, newY:Number, displacementX:Number, displacementY:Number):void
		{
			rectangle1.x = newX - widthFactor;
			rectangle1.y = newY - worldHeight / 3 + heightFactor;
		}
		
		public function aGrab1(clickX:Number, clickY:Number):void
		{
			rectangle1.x = clickX - widthFactor;
			rectangle1.y = clickY - worldHeight / 3 + heightFactor;
		}
		
		public function aDrop2(newX:Number, newY:Number, displacementX:Number, displacementY:Number):void
		{
			rectangle2.x = newX - (2 * worldWidth/3) - widthFactor;
			rectangle2.y = newY - (2 * worldHeight / 3) + heightFactor;
			
			if ((newY > pointY1) && (newY < pointY2) && (newX < pointX1))
			{
				flag2[0] = 1;
			}
			else
			{
				flag2[0] = 0;
			}
			
			if ((newY > pointY1) && (newY < pointY2) && (newX < pointX2) && (newX > worldWidth / 6))
			{
				flag2[1] = 1;
			}
			else
			{
				flag2[1] = 0;
			}
			
			if ((newY > pointY1) && (newY < pointY2) && (newX > pointX2) && (newX < pointX3))
			{
				flag2[2] = 1;
			}
			else
			{
				flag2[2] = 0;
			}
			
			if ((newY > pointY1)  && (newY < pointY2) && (newX > pointX3) && (newX < pointX4))
			{
				flag2[3] = 1;
			}
			else
			{
				flag2[3] = 0;
			}
			
			if ((newY > pointY1)  && (newY < pointY2) && (newX > pointX4) && (newX < pointX5))
			{
				flag2[4] = 1;
			}
			else
			{
				flag2[4] = 0;
			}
			
			if ((newY > pointY1) && (newY < pointY2) &&  (newX > pointX5) && (newX < worldWidth))
			{
				flag2[5] = 1;
			}
			else
			{
				flag2[5] = 0;
			}
		}
		
		public function aDrag2(newX:Number, newY:Number, displacementX:Number, displacementY:Number):void
		{
			rectangle2.x = newX - (2 * worldWidth/3) - widthFactor;
			rectangle2.y = newY - (2 * worldHeight/3) + heightFactor;
		}
		
		public function aGrab2(clickX:Number, clickY:Number):void
		{
			rectangle2.x = clickX - (2 * worldWidth/3) - widthFactor;
			rectangle2.y = clickY - (2 * worldHeight/3) + heightFactor;
		}
		
		public function aDrop3(newX:Number, newY:Number, displacementX:Number, displacementY:Number):void
		{
			rectangle3.x = newX - ( worldWidth/3) - widthFactor;
			rectangle3.y = newY - (worldHeight / 3) + heightFactor;
			
			if ((newY > pointY1) && (newY < pointY2) && (newX < pointX1))
			{
				flag3[0] = 1;
			}
			else
			{
				flag3[0] = 0;
			}
			
			if ((newY > pointY1) && (newY < pointY2) && (newX < pointX2) && (newX > worldWidth / 6))
			{
				flag3[1] = 1;
			}
			else
			{
				flag3[1] = 0;
			}
			
			if ((newY > pointY1) && (newY < pointY2) && (newX > pointX2) && (newX < pointX3))
			{
				flag3[2] = 1;
			}
			else
			{
				flag3[2] = 0;
			}
			
			if ((newY > pointY1)  && (newY < pointY2) && (newX > pointX3) && (newX < pointX4))
			{
				flag3[3] = 1;
			}
			else
			{
				flag3[3] = 0;
			}
			
			if ((newY > pointY1)  && (newY < pointY2) && (newX > pointX4) && (newX < pointX5))
			{
				flag3[4] = 1;
			}
			else
			{
				flag3[4] = 0;
			}
			
			if ((newY > pointY1) && (newY < pointY2) &&  (newX > pointX5) && (newX < worldWidth))
			{
				flag3[5] = 1;
			}
			else
			{
				flag3[5] = 0;
			}
		}
		
		public function aDrag3(newX:Number, newY:Number, displacementX:Number, displacementY:Number):void
		{
			rectangle3.x = newX - ( worldWidth/3) - widthFactor;
			rectangle3.y = newY - ( worldHeight/3) + heightFactor;
		}
		
		public function aGrab3(clickX:Number, clickY:Number):void
		{
			rectangle3.x = clickX - (worldWidth/3) - widthFactor;
			rectangle3.y = clickY - (worldHeight/3) + heightFactor;
		}
		
		public function aDrop4(newX:Number, newY:Number, displacementX:Number, displacementY:Number):void
		{
			rectangle4.x = newX - ( worldWidth/3) - widthFactor;
			rectangle4.y = newY - (2 * worldHeight / 3) + heightFactor;
			
			if ((newY > pointY1) && (newY < pointY2) && (newX < pointX1))
			{
				flag4[0] = 1;
			}
			else
			{
				flag4[0] = 0;
			}
			
			if ((newY > pointY1) && (newY < pointY2) && (newX < pointX2) && (newX > worldWidth / 6))
			{
				flag4[1] = 1;
			}
			else
			{
				flag4[1] = 0;
			}
			
			if ((newY > pointY1) && (newY < pointY2) && (newX > pointX2) && (newX < pointX3))
			{
				flag4[2] = 1;
			}
			else
			{
				flag4[2] = 0;
			}
			
			if ((newY > pointY1)  && (newY < pointY2) && (newX > pointX3) && (newX < pointX4))
			{
				flag4[3] = 1;
			}
			else
			{
				flag4[3] = 0;
			}
			
			if ((newY > pointY1)  && (newY < pointY2) && (newX > pointX4) && (newX < pointX5))
			{
				flag4[4] = 1;
			}
			else
			{
				flag4[4] = 0;
			}
			
			if ((newY > pointY1) && (newY < pointY2) &&  (newX > pointX5) && (newX < worldWidth))
			{
				flag4[5] = 1;
			}
			else
			{
				flag4[5] = 0;
			}
		}
		
		public function aDrag4(newX:Number, newY:Number, displacementX:Number, displacementY:Number):void
		{
			rectangle4.x = newX - ( worldWidth/3) - widthFactor;
			rectangle4.y = newY - (2 * worldHeight/3) + heightFactor;
		}
		
		public function aGrab4(clickX:Number, clickY:Number):void
		{
			rectangle4.x = clickX - ( worldWidth/3) - widthFactor;
			rectangle4.y = clickY - (2 * worldHeight/3) + heightFactor;
		}
		
		public function aDrop5(newX:Number, newY:Number, displacementX:Number, displacementY:Number):void
		{
			rectangle5.x = newX - (2 * worldWidth/3) - widthFactor;
			rectangle5.y = newY - ( worldHeight / 3) + heightFactor;
			
			if ((newY > pointY1) && (newY < pointY2) && (newX < pointX1))
			{
				flag5[0] = 1;
			}
			else
			{
				flag5[0] = 0;
			}
			
			if ((newY > pointY1) && (newY < pointY2) && (newX < pointX2) && (newX > worldWidth / 6))
			{
				flag5[1] = 1;
			}
			else
			{
				flag5[1] = 0;
			}
			
			if ((newY > pointY1) && (newY < pointY2) && (newX > pointX2) && (newX < pointX3))
			{
				flag5[2] = 1;
			}
			else
			{
				flag5[2] = 0;
			}
			
			if ((newY > pointY1)  && (newY < pointY2) && (newX > pointX3) && (newX < pointX4))
			{
				flag5[3] = 1;
			}
			else
			{
				flag5[3] = 0;
			}
			
			if ((newY > pointY1)  && (newY < pointY2) && (newX > pointX4) && (newX < pointX5))
			{
				flag5[4] = 1;
			}
			else
			{
				flag5[4] = 0;
			}
			
			if ((newY > pointY1) && (newY < pointY2) &&  (newX > pointX5) && (newX < worldWidth))
			{
				flag5[5] = 1;
			}
			else
			{
				flag5[5] = 0;
			}
		}
		
		public function aDrag5(newX:Number, newY:Number, displacementX:Number, displacementY:Number):void
		{
			rectangle5.x = newX - (2 * worldWidth/3) - widthFactor;
			rectangle5.y = newY - ( worldHeight/3) + heightFactor;
		}
		
		public function aGrab5(clickX:Number, clickY:Number):void
		{
			rectangle5.x = clickX - (2 * worldWidth/3) - widthFactor;
			rectangle5.y = clickY - ( worldHeight/3) + heightFactor;
		}
		
		public function aDrop6(newX:Number, newY:Number, displacementX:Number, displacementY:Number):void
		{
			rectangle6.x = newX - widthFactor;
			rectangle6.y = newY - (2 * worldHeight / 3) + heightFactor;
			
			if ((newY > pointY1) && (newY < pointY2) && (newX < pointX1))
			{
				flag6[0] = 1;
			}
			else
			{
				flag6[0] = 0;
			}
			
			if ((newY > pointY1) && (newY < pointY2) && (newX < pointX2) && (newX > worldWidth / 6))
			{
				flag6[1] = 1;
			}
			else
			{
				flag6[1] = 0;
			}
			
			if ((newY > pointY1) && (newY < pointY2) && (newX > pointX2) && (newX < pointX3))
			{
				flag6[2] = 1;
			}
			else
			{
				flag6[2] = 0;
			}
			
			if ((newY > pointY1)  && (newY < pointY2) && (newX > pointX3) && (newX < pointX4))
			{
				flag6[3] = 1;
			}
			else
			{
				flag6[3] = 0;
			}
			
			if ((newY > pointY1)  && (newY < pointY2) && (newX > pointX4) && (newX < pointX5))
			{
				flag6[4] = 1;
			}
			else
			{
				flag6[4] = 0;
			}
			
			if ((newY > pointY1) && (newY < pointY2) &&  (newX > pointX5) && (newX < worldWidth))
			{
				flag6[5] = 1;
			}
			else
			{
				flag6[5] = 0;
			}
		}
		
		public function aDrag6(newX:Number, newY:Number, displacementX:Number, displacementY:Number):void
		{
			rectangle6.x = newX  - widthFactor;
			rectangle6.y = newY - (2 * worldHeight/3) + heightFactor;
		}
		
		public function aGrab6(clickX:Number, clickY:Number):void
		{
			rectangle6.x = clickX - widthFactor;
			rectangle6.y = clickY - (2 * worldHeight/3) + heightFactor;
		}
		
		/*public function setupTextBoxes():void
		{
			var rect:Vector.<PIErectangle>;
			rect = new Vector.<PIErectangle>(6);
			
			//rect[1] = new PIErectangle(pieHandle, 
		}*/
		
		public function nextFrame():void
		{
			
		}
		
	}

}