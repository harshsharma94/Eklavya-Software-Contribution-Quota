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
		private var pieHandle:PIE; //project framework handle
		
		private var nextButton:PIEbutton;
		private var startButton:PIEbutton;
		private var rhymingArray:Array;
		
		//Colors
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
		
		private var rectangle1:PIErectangle;
		private var rectangle2:PIErectangle;
		private var rectangle3:PIErectangle;
		private var rectangle4:PIErectangle;
		private var rectangle5:PIErectangle;
		private var rectangle6:PIErectangle;
		
		private var word1:PIElabel;
		private var word2:PIElabel;
		private var word3:PIElabel;
		private var word4:PIElabel;
		private var word5:PIElabel;
		private var word6:PIElabel;
		
		private var status1:PIElabel;
		private var status2:PIElabel;
		private var status3:PIElabel;
		
		private var incorrectLabel1:PIElabel;
		private var incorrectLabel2:PIElabel;
		private var incorrectLabel3:PIElabel;

		private var flag1:Array;
		private var flag2:Array;
		private var flag3:Array;
		private var flag4:Array;
		private var flag5:Array;
		private var flag6:Array;
		
		//instr: instruction
		//intro: introduction
		private var instr:PIElabel;
		private var intro:PIElabel;
		
		private var line1:PIEline;
		private var line2:PIEline;
		private var line3:PIEline;
		private var line4:PIEline;
		private var line5:PIEline;
		
		private var random:Number;
		private var max:Number;
		private var min:Number;
		
		public function Experiment(pie:PIE)
		{
			pieHandle = pie;//store handle of pie framework
			
			pieHandle.PIEsetDrawingArea(1.0, 1.0);
			pieHandle.PIEsetUIpanelInvisible();
			
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
			
			rhymingArray = new Array("File", "Pile", "Got", "Lot", "Rat", "Hat", "Braces", "Laces", "Belt", "Felt",
					"Boot", "Suit", "Clip", "Slip", "Fowl", "Owl", "Germ", "Worm", "Goose", "Moose",
					"Hen", "Wren", "Lark", "Shark", "Mole", "Vole", "Deer", "Steer", "Buck", "Duck",
					"Bug", "Pug", "Locket", "Pocket", "Shirt", "Skirt", "Pool", "Fool", "New", "Few",
					"Love", "Dove", "Boot", "Foot", "Bat", "Sat", "Fear", "Clear", "Brief", "Thief",
					"Cherry", "Merry", "Chill", "Pill", "Chop", "Shop", "Dorm", "Storm", "Dream", "Team",
					"Fill", "Mill", "Fight", "Night", "Flash", "Crash", "Ground", "Round", "Hard", "Card",
					"Heat", "Treat", "Humpty", "Dumpty", "Ill", "Will", "Kick", "Stick", "Trash", "Cash",
					"Top", "Cop", "Sure", "Cure", "Hot", "Pot", "Gold", "Cold", "Tense", "Sense",
					"Dream", "Steam", "Around", "Ground", "May", "Day", "See", "Tree", "Weeds", "Deeds",
					"Flatter", "Matter", "Wall", "Fall", "Ears", "Tears", "Quick", "Stick", "Mind", "Blind");
					
			min = 0;
			max = 93;//should be Max - 6 so that atleast six words appear
			random = (Math.floor(Math.random() * (1 + max - min)) + min);
			if (random % 2 != 0)
				random = random - 1;
			
			this.resetWorld();
			
			pieHandle.showExperimentName("Word Building");
			pieHandle.showDeveloperName("Harsh Sharma");
		}
		
		public function handleStart():void
		{
			this.initLines();
			this.initRects();
			initLabels(rhymingArray[random++], rhymingArray[random++], rhymingArray[random++],
				rhymingArray[random++], rhymingArray[random++], rhymingArray[random++]);
			nextButton.visible = true;
			startButton.visible = false;
			intro.visible = false;
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
			
			/*removeIncorrect1();
			removeIncorrect2();
			removeIncorrect3();
			removeStatus1();
			removeStatus2();
			removeStatus3();*/
			
			if (status1)
			{
				status1.text = "";
				status1.background = false;
			}
			if (status2)
			{
				status2.text = "";
				status2.background = false;
			}
			if (status3)
			{
				status3.text = "";
				status3.background = false;
			}
			if (incorrectLabel1)
			{
				incorrectLabel1.text = "";
				incorrectLabel1.background = false;
			}
			
			if (incorrectLabel2)
			{
				incorrectLabel2.text = "";
				incorrectLabel2.background = false;
			}
			
			if (incorrectLabel3)
			{
				incorrectLabel3.text = "";
				incorrectLabel3.background = false;
			}
			
			/*pieHandle.experimentDisplay.removeChild(rectangle1);
			pieHandle.experimentDisplay.removeChild(rectangle2);
			pieHandle.experimentDisplay.removeChild(rectangle3);
			pieHandle.experimentDisplay.removeChild(rectangle4);
			pieHandle.experimentDisplay.removeChild(rectangle5);
			pieHandle.experimentDisplay.removeChild(rectangle6);*/
			/*word1.replaceText(0, word1.length, "");
			word2.replaceText(0, word2.length, "");
			word3.replaceText(0, word3.length, "");
			word4.replaceText(0, word4.length, "");
			word5.replaceText(0, word5.length, "");
			word6.replaceText(0, word6.length, "");*/
			
			/*word1.visible = false;
			word2.visible = false;
			word3.visible = false;
			word4.visible = false;
			word5.visible = false;
			word6.visible = false;*/
			
			/*pieHandle.removeChild(word1);
			pieHandle.removeChild(word2);
			pieHandle.removeChild(word3);
			pieHandle.removeChild(word4);
			pieHandle.removeChild(word5);
			pieHandle.removeChild(word6);*/
			
			initRects();
			min = 0;
			max = 93;// should be max - 6 so that  atleast 6 are selected
			random = (Math.floor(Math.random() * (1 + max - min)) + min);
			if (random % 2 != 0)
				random = random - 1;
			initLabels(rhymingArray[random++], rhymingArray[random++], rhymingArray[random++],
				rhymingArray[random++], rhymingArray[random++], rhymingArray[random++]);
				
			flag1 = new Array(0, 0, 0);
			flag2 = new Array(0, 0, 0);
			flag3 = new Array(0, 0, 0);
			flag4 = new Array(0, 0, 0);
			flag5 = new Array(0, 0, 0);
			flag6 = new Array(0, 0, 0);
				
		}
		
		public function resetWorld():void
		{
			/* get the PIE drawing area aspect ratio (width/height) to model the dimensions of our experiment area */
			//PIEaspectRatio = pieHandle.PIEgetDrawingAspectRatio();
			
			/* Initialise World Origin and Boundaries */
			worldHeight = pieHandle.experimentDisplay.height;
			worldWidth = pieHandle.experimentDisplay.width;/* match world aspect ratio to PIE aspect ratio */
			worldOriginX = 0;               /* Origin at Uppermost Left Corner */
			worldOriginY = 0;
			pieHandle.PIEsetApplicationBoundaries(worldOriginX, worldOriginY, worldWidth, worldHeight);
			
			heightFactor = worldHeight / 6;
			widthFactor = worldWidth / 6;
			
			startButton	= new PIEbutton(pieHandle, "Ready !!");
			startButton.setActualSize(worldWidth / 12, worldHeight / 12);
			startButton.addClickListener(handleStart);
			startButton.setVisible(true);
			pieHandle.addChild(startButton);
			startButton.x = worldWidth-widthFactor;
			startButton.y = worldHeight-heightFactor/2;
			
			nextButton = new PIEbutton(pieHandle, "NEXT");
			nextButton.setActualSize(worldWidth / 20, worldHeight / 20);
			nextButton.addClickListener(handleNext);
			nextButton.setVisible(true);
            pieHandle.addChild(nextButton);
			nextButton.x = worldWidth - widthFactor/2;
			nextButton.y = heightFactor / 2;
			nextButton.visible = false;
			
			intro = new PIElabel(pieHandle,
				" The Goal of this Activity is to \n\t\tImprove Reading Skills by learning Rhyming Words.\n" +
				" Rhyming Words are simply those words that sound alike.\n"+
				" Drag the two Rhyming words one by one and\n\t\t Drop them to any of the three boxes below.\n" +
				" The label above each box displays \"Correct\" if the two words Rhyme.\n" +
				" It displays \"Incorrect\" if you Drop Wrong words or for other cases.\n" +
				" Press Next to move on to other Quiz\n"+
				" Enjoy.",
				worldWidth /40 , displayBColor, headingTextColor);
			pieHandle.addDisplayChild(intro);
			intro.background = false;
			intro.x = widthFactor;
			intro.y =  heightFactor;
			
			flag1 = new Array(0, 0, 0);
			flag2 = new Array(0, 0, 0);
			flag3 = new Array(0, 0, 0);
			flag4 = new Array(0, 0, 0);
			flag5 = new Array(0, 0, 0);
			flag6 = new Array(0, 0, 0);
				
		}
		
		public function initRects():void
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
		
		public function callStatus1():void
		{
			if (status1)
			{
				status1.text = ""
				status1.background = false;
			}
			if (incorrectLabel1)
			{
				incorrectLabel1.text = "";
				incorrectLabel1.background = false;
			}
			status1 = new PIElabel(pieHandle, "   CORRECT ", worldWidth / 30, greenColor, headingTextColor);
			status1.width = widthFactor * 1.3;
			status1.setLabelBold(true);
			pieHandle.addDisplayChild(status1);
			status1.x = (worldWidth / 12);
			status1.y = (worldHeight / 12);
			
		}
		
		public function callStatus2():void
		{
			if (status2)
			{
				status2.text = "";
				status2.background = false;
			}
			if (incorrectLabel2)
			{
				incorrectLabel2.text = "";
				incorrectLabel2.background = false;
			}
			status2 = new PIElabel(pieHandle, "   CORRECT ", worldWidth / 30, greenColor, headingTextColor);
			status2.width = widthFactor*1.3;
			pieHandle.addDisplayChild(status2);
			status2.x = (5 * worldWidth / 12);
			status2.y = (worldHeight / 12);
			
		}
		
		public function callStatus3():void
		{
			if (status3)
			{
				status3.text = "";
				status3.background = false;
			}
			if (incorrectLabel3)
			{
				incorrectLabel3.text = "";
				incorrectLabel3.background = false;
			}
			status3 = new PIElabel(pieHandle, "   CORRECT ", worldWidth / 30, greenColor, headingTextColor);
			status3.width = widthFactor*1.3;
			pieHandle.addDisplayChild(status3);
			status3.x = (9 * worldWidth / 12);
			status3.y = (worldHeight / 12);
			
		}
		
		public function removeStatus1():void
		{
			if(status1)
				pieHandle.experimentDisplay.removeChild(status1);
		}
		
		public function removeStatus2():void
		{
			if(status2)
				pieHandle.experimentDisplay.removeChild(status2);
		}
		
		public function removeStatus3():void
		{
			if(status3)
				pieHandle.experimentDisplay.removeChild(status3);
		}
		
		public function callIncorrect1():void
		{
			if (status1)
			{
				status1.text = ""
				status1.background = false;
			}
			if (incorrectLabel1)
			{
				incorrectLabel1.text = "";
				incorrectLabel1.background = false;
			}
			incorrectLabel1 = new PIElabel(pieHandle, "INCORRECT", worldWidth / 30, redColor, headingTextColor);
			incorrectLabel1.width = widthFactor*1.3;
			pieHandle.addDisplayChild(incorrectLabel1);
			incorrectLabel1.x = (worldWidth / 12);
			incorrectLabel1.y = (worldHeight / 12);
		}
		public function callIncorrect2():void
		{
			if (status2)
			{
				status2.text = "";
				status2.background = false;
			}
			if (incorrectLabel2)
			{
				incorrectLabel2.text = "";
				incorrectLabel2.background = false;
			}
			
			incorrectLabel2 = new PIElabel(pieHandle, "INCORRECT", worldWidth / 30, redColor, headingTextColor);
			incorrectLabel2.width = widthFactor*1.3;
			pieHandle.addDisplayChild(incorrectLabel2);
			incorrectLabel2.x = (5 * worldWidth / 12);
			incorrectLabel2.y = (worldHeight / 12);
		}
		public function callIncorrect3():void
		{
			if (status3)
			{
				status3.text = "";
				status3.background = false;
			}
			if (incorrectLabel3)
			{
				incorrectLabel3.text = "";
				incorrectLabel3.background = false;
			}
			incorrectLabel3 = new PIElabel(pieHandle, "INCORRECT", worldWidth / 30, redColor, headingTextColor);
			incorrectLabel3.width = widthFactor*1.3;
			pieHandle.addDisplayChild(incorrectLabel3);
			incorrectLabel3.x = (9 * worldWidth / 12);
			incorrectLabel3.y = (worldHeight / 12);
		}
		public function removeIncorrect1():void
		{
			if(incorrectLabel1)
				pieHandle.experimentDisplay.removeChild(incorrectLabel1);
		}
		public function removeIncorrect2():void
		{
			if(incorrectLabel2)
				pieHandle.experimentDisplay.removeChild(incorrectLabel2);
		}
		public function removeIncorrect3():void
		{
			if(incorrectLabel3)
				pieHandle.experimentDisplay.removeChild(incorrectLabel3);
		}
	
		
		public function initLabels(w1:String, w2:String, w3:String, w4:String, w5:String, w6:String):void
		{
			instr = new PIElabel(pieHandle, "Drag the Rhyming Words into any of the three boxes below",
				worldWidth / 35 , controlBColor, headingTextColor);
			instr.setLabelUnderline(true);
			instr.setLabelItalic(true);
			instr.background = false;
			instr.x = ( widthFactor);
			pieHandle.addDisplayChild(instr);
			
			word1 = new PIElabel(pieHandle, w1,
				worldWidth / 30 , controlBColor, headingTextColor);
			word1.background = false;
			word1.x = widthFactor;
			word1.y = worldHeight / 3 - heightFactor;
			rectangle1.addChild(word1);
			
			word2 = new PIElabel(pieHandle, w2,
				worldWidth / 30, controlBColor, headingTextColor);
			word2.background = false;
			word2.x = (2 * worldWidth / 3) + widthFactor;
			word2.y = (2 * worldHeight / 3) - heightFactor;
			rectangle2.addChild(word2);
			
			word3 = new PIElabel(pieHandle, w3,
				worldWidth / 30 , controlBColor, headingTextColor);
			word3.background = false;
			word3.x = worldWidth/3 + widthFactor;
			word3.y = worldHeight / 3 - heightFactor;
			rectangle3.addChild(word3);
			
			word4 = new PIElabel(pieHandle, w4,
				worldWidth / 30, controlBColor, headingTextColor);
			word4.background = false;
			word4.x = (worldWidth/3) + widthFactor;
			word4.y = (2 * worldHeight / 3) - heightFactor;
			rectangle4.addChild(word4);
			
			word5 = new PIElabel(pieHandle, w5,
				worldWidth / 30 , controlBColor, headingTextColor);
			word5.background = false;
			word5.x = (2 * worldWidth/3) + widthFactor;
			word5.y = (worldHeight / 3) - heightFactor;
			rectangle5.addChild(word5);
			
			word6 = new PIElabel(pieHandle, w6,
				worldWidth / 30, controlBColor, headingTextColor);
			word6.background = false;
			word6.x = 0 + widthFactor;
			word6.y = (2 * worldHeight / 3) - heightFactor;
			rectangle6.addChild(word6);
		}

		public function initLines():void
		{
			line1 = new PIEline(pieHandle, 0, ( 2 * worldHeight / 3), (worldWidth / 3), ( 2 * worldHeight / 3), violetColor, worldWidth / 300, worldWidth / 50);
			pieHandle.addDisplayChild(line1);
			line2 = new PIEline(pieHandle, (worldWidth / 3), (2 * worldHeight / 3), (worldWidth / 3), (worldHeight), violetColor, worldWidth / 300, worldWidth / 50);
			pieHandle.addDisplayChild(line2);
			line3 = new PIEline(pieHandle, (worldWidth / 3), (2 * worldHeight / 3), (2 * worldWidth / 3), (2 *worldHeight / 3), violetColor, worldWidth / 300, worldWidth / 50);
			pieHandle.addDisplayChild(line3);
			line4 = new PIEline(pieHandle, (2 * worldWidth / 3), (2 * worldHeight / 3), (2 * worldWidth / 3), (worldHeight), violetColor, worldWidth / 300, worldWidth / 50);
			pieHandle.addDisplayChild(line4);
			line5 = new PIEline(pieHandle, (2 * worldWidth / 3), (2 * worldHeight / 3), (worldWidth), (2 * worldHeight/ 3), violetColor, worldWidth / 300, worldWidth / 50);
			pieHandle.addDisplayChild(line5);
			
		}
		
		public function aDrop1(newX:Number, newY:Number, displacementX:Number, displacementY:Number):void
		{
			if ((newY > (2 * worldHeight/3)) && (newX < (worldWidth/3)))
			{
				flag1[0] = 1;
			}
			else
			{
				flag1[0] = 0;
			}
			
			if ((newY > (2 * worldHeight/3)) && (newX < (2 * worldWidth/3)) && (newX > worldWidth / 3))
			{
				flag1[1] = 1;
			}
			else
			{
				flag1[1] = 0;
			}
			
			if ((newY > (2 * worldHeight/3)) && (newX > (2 * worldWidth/3)))
			{
				flag1[2] = 1;
			}
			else
			{
				flag1[2] = 0;
			}
			
			rectangle1.x = newX - widthFactor;
			rectangle1.y = newY - worldHeight / 3 + heightFactor;
			
			if (flag1[0] == 1 && flag2[0] == 1 && flag3[0]==0 && flag4[0]==0 && flag5[0]==0 && flag6[0]==0)
			{
				//removeIncorrect1();
				callStatus1();
				word1.setLabelBColor(greenColor);
				word2.setLabelBColor(greenColor);
			}
			else if ((flag1[0] == 1 && flag3[0] == 1) || (flag1[0] == 1 && flag4[0] == 1) || (flag1[0] == 1 && flag5[0] == 1)
				|| (flag1[0]==1 && flag6[0]==1))
			{
				callIncorrect1();
				//removeStatus1();
			}
			
			if (flag1[1] == 1 && flag2[1] == 1 && flag3[1]==0 && flag4[1]==0 && flag5[1]==0 && flag6[1]==0)
			{
				//removeIncorrect2();
				callStatus2();
				word1.setLabelBColor(greenColor);
				word2.setLabelBColor(greenColor);
			}
			else if ((flag1[1] == 1 && flag3[1] == 1) || (flag1[1] == 1 && flag4[1] == 1) || (flag1[1] == 1 && flag5[1] == 1)
				|| (flag1[1]==1 && flag6[1]==1))
			{
				callIncorrect2();
				//removeStatus2();
			}
			
			
			if (flag1[2] == 1 && flag2[2] == 1 && flag3[2]==0 && flag4[2]==0 && flag5[2]==0 && flag6[2]==0)
			{
				//removeIncorrect3();
				callStatus3();
				word1.setLabelBColor(greenColor);
				word2.setLabelBColor(greenColor);
			}
			else if ((flag1[2] == 1 && flag3[2] == 1) || (flag1[2] == 1 && flag4[2] == 1) || (flag1[2] == 1 && flag5[2] == 1)
				|| (flag1[2]==1 && flag6[2]==1))
			{
				callIncorrect3();
				//removeStatus3();
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
			if ((newY > (2 * worldHeight/3)) && (newX < (worldWidth/3)))
			{
				flag2[0] = 1;
			}
			else
			{
				flag2[0] = 0;
			}
			
			if ((newY > (2 * worldHeight/3)) && (newX < (2 * worldWidth/3)) && (newX > worldWidth / 3))
			{
				flag2[1] = 1;
			}
			else
			{
				flag2[1] = 0;
			}
			
			if ((newY > (2 * worldHeight/3)) && (newX > (2 * worldWidth/3)))
			{
				flag2[2] = 1;
			}
			else
			{
				flag2[2] = 0;
			}
			
			rectangle2.x = newX - (2 * worldWidth/3) - widthFactor;
			rectangle2.y = newY - (2 * worldHeight/3) + heightFactor;
			
			if (flag1[0] == 1 && flag2[0] == 1 && flag3[0]==0 && flag4[0]==0 && flag5[0]==0 && flag6[0]==0)
			{
				//removeIncorrect1();
				callStatus1();
				word1.setLabelBColor(greenColor);
				word2.setLabelBColor(greenColor);
			}
			else if ((flag1[0] == 1 && flag3[0] == 1) || (flag1[0] == 1 && flag4[0] == 1) || (flag1[0] == 1 && flag5[0] == 1)
				|| (flag1[0]==1 && flag6[0]==1))
			{
				callIncorrect1();
				//removeStatus1();
			}
			
			if (flag1[1] == 1 && flag2[1] == 1 && flag3[1]==0 && flag4[1]==0 && flag5[1]==0 && flag6[1]==0)
			{
				//removeIncorrect2();
				callStatus2();
				word1.setLabelBColor(greenColor);
				word2.setLabelBColor(greenColor);
			}
			else if ((flag1[1] == 1 && flag3[1] == 1) || (flag1[1] == 1 && flag4[1] == 1) || (flag1[1] == 1 && flag5[1] == 1)
				|| (flag1[1]==1 && flag6[1]==1))
			{
				callIncorrect2();
				//removeStatus2();
			}
			
			if (flag1[2] == 1 && flag2[2] == 1 && flag3[2]==0 && flag4[2]==0 && flag5[2]==0 && flag6[2]==0)
			{
				//removeIncorrect3();
				callStatus3();
				word1.setLabelBColor(greenColor);
				word2.setLabelBColor(greenColor);
			}
			else if ((flag2[2] == 1 && flag3[2] == 1) || (flag2[2] == 1 && flag4[2] == 1) || (flag2[2] == 1 && flag5[2] == 1)
				|| (flag2[2]==1 && flag6[2]==1))
			{
				callIncorrect3();
				//removeStatus3();
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
			if ((newY > (2 * worldHeight/3)) && (newX < (worldWidth/3)))
			{
				flag3[0] = 1;
			}
			else
			{
				flag3[0] = 0;
			}
			
			if ((newY > (2 * worldHeight/3)) && (newX < (2 * worldWidth/3)) && (newX > worldWidth / 3))
			{
				flag3[1] = 1;
			}
			else
			{
				flag3[1] = 0;
			}
			
			if ((newY > (2 * worldHeight/3)) && (newX > (2 * worldWidth/3)))
			{
				flag3[2] = 1;
			}
			else
			{
				flag3[2] = 0;
			}
			
			rectangle3.x = newX - ( worldWidth/3) - widthFactor;
			rectangle3.y = newY - (worldHeight/3) + heightFactor;
			
			if (flag3[0] == 1 && flag4[0] == 1 && flag1[0]==0 && flag2[0]==0 && flag5[0]==0 && flag6[0]==0)
			{
				//removeIncorrect1();
				callStatus1();
				word3.setLabelBColor(greenColor);
				word4.setLabelBColor(greenColor);
			}
			else if ((flag3[0] == 1 && flag1[0] == 1) || (flag3[0] == 1 && flag2[0] == 1) || (flag3[0] == 1 && flag5[0] == 1)
				|| (flag3[0]==1 && flag6[0]==1))
			{
				callIncorrect1();
				//removeStatus1();
			}
			
			if (flag3[1] == 1 && flag4[1] == 1 && flag1[1] == 0 && flag2[1]==0 && flag5[1]==0 && flag6[1]==0 )
			{
				//removeIncorrect2();
				callStatus2();
				word3.setLabelBColor(greenColor);
				word4.setLabelBColor(greenColor);
			}
			else if ((flag3[1] == 1 && flag1[1] == 1) || (flag3[1] == 1 && flag2[1] == 1) || (flag3[1] == 1 && flag5[1] == 1)
				|| (flag3[1]==1 && flag6[1]==1))
			{
				callIncorrect2();
				//removeStatus2();
			}
			
			if (flag3[2] == 1 && flag4[2] == 1 && flag1[2]==0 && flag2[2]==0 && flag5[2]==0 && flag6[2]==0)
			{
				//removeIncorrect3();
				callStatus3();
				word3.setLabelBColor(greenColor);
				word4.setLabelBColor(greenColor);
			}
			else if ((flag3[2] == 1 && flag1[2] == 1) || (flag3[2] == 1 && flag2[2] == 1) || (flag3[2] == 1 && flag5[2] == 1)
				|| (flag3[2]==1 && flag6[2]==1))
			{
				callIncorrect3();
				//removeStatus3();
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
			if ((newY > (2 * worldHeight/3)) && (newX < (worldWidth/3)))
			{
				flag4[0] = 1;
			}
			else
			{
				flag4[0] = 0;
			}
			
			if ((newY > (2 * worldHeight/3)) && (newX < (2 * worldWidth/3)) && (newX > worldWidth / 3))
			{
				flag4[1] = 1;
			}
			else
			{
				flag4[1] = 0;
			}
			
			if ((newY > (2 * worldHeight/3)) && (newX > (2 * worldWidth/3)))
			{
				flag4[2] = 1;
			}
			else
			{
				flag4[2] = 0;
			}
			
			rectangle4.x = newX - ( worldWidth/3) - widthFactor;
			rectangle4.y = newY - (2 * worldHeight/3) + heightFactor;
			
			if (flag3[0] == 1 && flag4[0] == 1 && flag1[0]==0 && flag2[0]==0 && flag5[0]==0 && flag6[0]==0)
			{
				//removeIncorrect1();
				callStatus1();
				word3.setLabelBColor(greenColor);
				word4.setLabelBColor(greenColor);
			}
			else if ((flag4[0] == 1 && flag1[0] == 1) || (flag4[0] == 1 && flag2[0] == 1) || (flag4[0] == 1 && flag5[0] == 1)
				|| (flag4[0]==1 && flag6[0]==1))
			{
				callIncorrect1();
				//removeStatus1();
			}
			
			if (flag3[1] == 1 && flag4[1] == 1 && flag1[1] == 0 && flag2[1]==0 && flag5[1]==0 && flag6[1]==0 )
			{
				//removeIncorrect2();
				callStatus2();
				word3.setLabelBColor(greenColor);
				word4.setLabelBColor(greenColor);
			}
			else if ((flag4[1] == 1 && flag1[1] == 1) || (flag4[1] == 1 && flag2[1] == 1) || (flag4[1] == 1 && flag5[1] == 1)
				|| (flag4[1]==1 && flag6[1]==1))
			{
				callIncorrect2();
				//removeStatus2();
			}
			
			if (flag3[2] == 1 && flag4[2] == 1 && flag1[2]==0 && flag2[1]==0 && flag5[2]==0 && flag6[2]==0)
			{
				//removeIncorrect3();
				callStatus3();
				word3.setLabelBColor(greenColor);
				word4.setLabelBColor(greenColor);
			}
			else if ((flag4[2] == 1 && flag1[2] == 1) || (flag4[2] == 1 && flag2[2] == 1) || (flag4[2] == 1 && flag5[2] == 1)
				|| (flag4[2]==1 && flag6[2]==1))
			{
				callIncorrect3();
				//removeStatus3();
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
			if ((newY > (2 * worldHeight/3)) && (newX < (worldWidth/3)))
			{
				flag5[0] = 1;
			}
			else
			{
				flag5[0] = 0;
			}
			
			if ((newY > (2 * worldHeight/3)) && (newX < (2 * worldWidth/3)) && (newX > worldWidth / 3))
			{
				flag5[1] = 1;
			}
			else
			{
				flag5[1] = 0;
			}
			
			if ((newY > (2 * worldHeight/3)) && (newX > (2 * worldWidth/3)))
			{
				flag5[2] = 1;
			}
			else
			{
				flag5[2] = 0;
			}
			
			rectangle5.x = newX - (2 * worldWidth/3) - widthFactor;
			rectangle5.y = newY - ( worldHeight/3) + heightFactor;
			
			if (flag5[0] == 1 && flag6[0] == 1 && flag1[0]==0 && flag2[0]==0 && flag3[0]==0 && flag4[0]==0)
			{
				//removeIncorrect1();
				callStatus1();
				word5.setLabelBColor(greenColor);
				word6.setLabelBColor(greenColor);
			}
			else if ((flag5[0] == 1 && flag1[0] == 1) || (flag5[0] == 1 && flag2[0] == 1) || (flag5[0] == 1 && flag3[0] == 1)
				|| (flag5[0]==1 && flag4[0]==1))
			{
				callIncorrect1();
				//removeStatus1();
			}
			
			if (flag5[1] == 1 && flag6[1] == 1 && flag1[1]==0 && flag2[1]==0 && flag3[1]==0 && flag4[1]==0)
			{
				//removeIncorrect2();
				callStatus2();
				word5.setLabelBColor(greenColor);
				word6.setLabelBColor(greenColor);
			}
			else if ((flag5[1] == 1 && flag1[1] == 1) || (flag5[1] == 1 && flag2[1] == 1) || (flag5[1] == 1 && flag3[1] == 1)
				|| (flag5[1]==1 && flag4[1]==1))
			{
				callIncorrect2();
				//removeStatus2();
			}
			if (flag5[2] == 1 && flag6[2] == 1 && flag1[2]==0 && flag2[2]==0 && flag3[2]==0 && flag4[2]==0)
			{
				//removeIncorrect3();
				callStatus3();
				word5.setLabelBColor(greenColor);
				word6.setLabelBColor(greenColor);
			}
			else if ((flag5[2] == 1 && flag1[2] == 1) || (flag5[2] == 1 && flag2[2] == 1) || (flag5[2] == 1 && flag3[2] == 1)
				|| (flag5[2]==1 && flag4[2]==1))
			{
				callIncorrect3();
				//removeStatus3();
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
			if ((newY > (2 * worldHeight/3)) && (newX < (worldWidth/3)))
			{
				flag6[0] = 1;
			}
			else
			{
				flag6[0] = 0;
			}
			
			if ((newY > (2 * worldHeight/3)) && (newX < (2 * worldWidth/3)) && (newX > worldWidth / 3))
			{
				flag6[1] = 1;
			}
			else
			{
				flag6[1] = 0;
			}
			
			if ((newY > (2 * worldHeight/3)) && (newX > (2 * worldWidth/3)))
			{
				flag6[2] = 1;
			}
			else
			{
				flag6[2] = 0;
			}
			
			rectangle6.x = newX - widthFactor;
			rectangle6.y = newY - (2 * worldHeight/3) + heightFactor;
			
			if (flag5[0] == 1 && flag6[0] == 1 && flag1[0]==0 && flag2[0]==0 && flag3[0]==0 && flag4[0]==0)
			{
				//removeIncorrect1();
				callStatus1();
				word5.setLabelBColor(greenColor);
				word6.setLabelBColor(greenColor);
			}
			else if ((flag6[0] == 1 && flag1[0] == 1) || (flag6[0] == 1 && flag2[0] == 1) || (flag6[0] == 1 && flag3[0] == 1)
				|| (flag6[0]==1 && flag4[0]==1))
			{
				callIncorrect1();
				//removeStatus1();
			}
			
			if (flag5[1] == 1 && flag6[1] == 1 && flag1[1]==0 && flag2[1]==0 && flag3[1]==0 && flag4[1]==0)
			{
				//removeIncorrect2();
				callStatus2();
				word5.setLabelBColor(greenColor);
				word6.setLabelBColor(greenColor);
			}
			else if ((flag6[1] == 1 && flag1[1] == 1) || (flag6[1] == 1 && flag2[1] == 1) || (flag6[1] == 1 && flag3[1] == 1)
				|| (flag6[1]==1 && flag4[1]==1))
			{
				callIncorrect2();
				//removeStatus2();
			}
			
			if (flag5[2] == 1 && flag6[2] == 1 && flag1[2]==0 && flag2[2]==0 && flag3[2]==0 && flag4[2]==0)
			{
				//removeIncorrect3();
				callStatus3();
				word5.setLabelBColor(greenColor);
				word6.setLabelBColor(greenColor);
			}
			else if ((flag6[2] == 1 && flag1[2] == 1) || (flag6[2] == 1 && flag2[2] == 1) || (flag6[2] == 1 && flag3[2] == 1)
				|| (flag6[2]==1 && flag4[2]==1))
			{
				callIncorrect3();
				//removeStatus3();
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
		
		public function nextFrame():void
		{
			
		}
		
	}

}