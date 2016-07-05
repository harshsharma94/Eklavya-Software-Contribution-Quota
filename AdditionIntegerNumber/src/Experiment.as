package
{
	import flash.geom.Point;
	import mx.controls.menuClasses.IMenuBarItemRenderer;
	import pie.graphicsLibrary.*;
	import pie.uiElements.*;
	import flash.display.LoaderInfo;
	
	public class Experiment
	{
		private var pieHandle:PIE;
		
		private var inumCount:Number;
		
		private var PIEaspectRatio:Number;
		private var worldOriginX:Number;
		private var worldOriginY:Number;
		private var worldWidth:Number;
		private var worldHeight:Number;
		
		private var widthFactor:Number;
		private var heightFactor:Number;
		
		private var displayBColor:uint;
		private var displayFColor:uint;
		private var UIpanelBColor:uint;
		private var UIpanelFColor:uint;
		private var controlBColor:uint;
		private var controlFColor:uint;
		private var headingTextColor:uint;
		private var backgroundActivityColor:uint;
		
		private var instr:PIElabel;
		private var input:PIElabelledInput;
		private var line:PIEline;
		
		private var max1:Number = 10;
		private var min1:Number = 0;
		private var max2:Number = -1;
		private var min2:Number = -10;
		
		private var num1:Number;
		private var num2:Number;
		
		private var numLabel1:PIElabel;
		private var numLabel2:PIElabel;
		
		private var label1:PIElabel;
		private var label2:PIElabel;
		
		private var sum:Number;
		private var sumLabel:PIElabel;
		private var arc:Vector.<PIEarc>;
		private var number:Vector.<PIElabel>;
		private var left:Number;
		private var right:Number;
		private var numLeft:Number;
		private var numRight:Number;
		private var totalNum:Number;
		
		private var sumValue:Number = 0;

		private var countNum:Number;
		private var sums:Vector.<PIElabel>;
		
		private var mode:String;
		
		private var repeatControl:PIEbutton;
		private var stepControl:PIEbutton;
		private var autoControl:PIEbutton;
		private var doneControl:PIEbutton;
		
		public function Experiment(pie:PIE)
		{
			/* Store handle of PIE Framework */
			pieHandle = pie;
			
			headingTextColor = 0XBFBFBF;
			backgroundActivityColor = 0X0D0D0D;
			
			pieHandle.PIEsetDrawingArea(1.0, 1.0);
			
			pieHandle.PIEsetUIpanelInvisible();
			
			resetWorld();
			
			pieHandle.PIEsetDisplayColors(backgroundActivityColor, displayFColor);
			pieHandle.PIEsetUIpanelColors(UIpanelBColor, UIpanelFColor);
			
			/* load parameters */
			pieHandle.loadParameters();
			/* Set the Experiment Details */
			pieHandle.showExperimentName("Addition on Integer Number Line");
			pieHandle.showDeveloperName("Harsh Sharma");
			
			/* init buttons */
			pieHandle.PIEcreateResetButton();
			pieHandle.ResetControl.visible = false;
			
			/* Create a repeat problem button */
			repeatControl = new PIEbutton(pieHandle, "Repeat");
			repeatControl.x = pieHandle.ResetControl.x;
			repeatControl.y = pieHandle.ResetControl.y - 5;
			repeatControl.width = 70;
			repeatControl.height = 22;
			repeatControl.visible = true;
			pieHandle.addTitleChild(repeatControl);
			repeatControl.addClickListener(this.repeatButtonPressed);
			
			/* Create a step by step  button */
			stepControl = new PIEbutton(pieHandle, "Step");
			stepControl.x = repeatControl.x + repeatControl.width + 10;
			stepControl.y = repeatControl.y;
			stepControl.width = 70;
			stepControl.height = 22;
			stepControl.visible = true;
			pieHandle.addTitleChild(stepControl);
			stepControl.addClickListener(this.stepButtonPressed);
			
			/* Create a auto  button */
			autoControl = new PIEbutton(pieHandle, "Auto");
			autoControl.x = stepControl.x + stepControl.width + 10;
			autoControl.y = stepControl.y;
			autoControl.width = 70;
			autoControl.height = 22;
			autoControl.visible = true;
			pieHandle.addTitleChild(autoControl);
			autoControl.addClickListener(this.autoButtonPressed);
			
			/* Create a done  button */
			doneControl = new PIEbutton(pieHandle, "Done");
			doneControl.x = autoControl.x + autoControl.width + 10;
			;
			doneControl.y = autoControl.y;
			doneControl.width = 70;
			doneControl.height = 22;
			doneControl.visible = true;
			pieHandle.addTitleChild(doneControl);
			doneControl.addClickListener(this.doneButtonPressed);
			
			/* read parameter */
			mode = pieHandle.getParameter("mode");
			
			/*for (i = 0; i < totalNum-1; i++)
			{
				arc[i] = new PIEarc(pieHandle, (number[i].x +  number[i + 1].x) / 2 , number[0].y, number[i].x, number[0].y, 180,headingTextColor);
				pieHandle.addDisplayChild(arc[i]);
				arc[i].rotationZ = 180;
			}*/

			if(mode=="demo")
			{
				startDemo();
			}
			else if (mode == "interactive")
			{
				startInteractive();
			}
			else if (mode == "guided")
			{
				startGuided();
			}
			else if (mode == "test")
			{
				startTest();
			}
			else
			{
				startDemo();
			}
			
			/* show hide buttons according to mode */
			showHideButtons();
		
		}
		
		public function resetWorld():void
		{
			worldWidth = pieHandle.experimentDisplay.width;
			worldHeight = pieHandle.experimentDisplay.height;
			
			worldOriginX = 0;
			worldOriginY = 0;
			pieHandle.PIEsetApplicationBoundaries(worldOriginX, worldOriginY, worldWidth, worldHeight);
			
			heightFactor = worldHeight / 6;
			widthFactor = worldWidth / 6;
		}
		
		public function startDemo():void 
		{
			label1 = new PIElabel(pieHandle, "First Number:", widthFactor / 4, backgroundActivityColor, headingTextColor);
			pieHandle.addDisplayChild(label1);
			label1.x = worldWidth / 4;
			label1.y = 0;

			num1 = (Math.floor(Math.random() * (1 + max1 - min1)) + min1);
			numLabel1 = new PIElabel(pieHandle, num1.toString(), widthFactor / 4 , backgroundActivityColor, headingTextColor);
			pieHandle.addDisplayChild(numLabel1);
			numLabel1.x = worldWidth / 3;
			numLabel1.y = worldHeight / 6;
			
			label2 = new PIElabel(pieHandle, "Second Number:", widthFactor / 4, backgroundActivityColor, headingTextColor);
			pieHandle.addDisplayChild(label2);
			label2.x = worldWidth / 4;
			label2.y = 2*worldHeight / 6;
			
			num2 = (Math.floor(Math.random() * (1 + max2 - min2)) + min2);
			numLabel2 = new PIElabel(pieHandle, num2.toString(), widthFactor / 4 , backgroundActivityColor, headingTextColor);
			pieHandle.addDisplayChild(numLabel2);
			numLabel2.x = worldWidth / 3;
			numLabel2.y =  worldHeight / 2;
			
			sum = num1 + num2;
			
			if (num1 > num2)
			{
				left = num2;
				right = num1;
			}
			else
			{
				right = num1;
				left = num2;
			}
			numLeft = Math.abs(left);
			numRight = right + 1;
			
			totalNum = numLeft + numRight;
			number = new Vector.<PIElabel>(totalNum);
			
			var i:Number;
			var count:Number = -1;
			for (i = left; i < 0; i++)
			{
				number[++count] = new PIElabel(pieHandle, i.toString(), widthFactor/7, backgroundActivityColor, headingTextColor);
				if (count == 0)
					number[count].x = 0;
				else
					number[count].x = (count) * worldWidth / totalNum;
				number[count].y = 7 * worldHeight / 9;
				pieHandle.addDisplayChild(number[count]);
			}
			for (i = 0; i <= right; i++)
			{
				number[++count] = new PIElabel(pieHandle, i.toString(), widthFactor/7, backgroundActivityColor, headingTextColor);
				number[count].x = (count) * worldWidth / totalNum;
				number[count].y = 7 * worldHeight / 9;
				pieHandle.addDisplayChild(number[count]);
				if (i == 0)
					number[count].backgroundColor = 0XFF0000;
			}
			line = new PIEline(pieHandle, number[0].x, number[0].y + worldHeight/25, number[totalNum - 1].x, number[totalNum - 1].y + worldHeight/25, 0X55961E, worldWidth / 500, worldWidth / 500);
			pieHandle.addDisplayChild(line);
			countNum = 0;
			sumLabel = new PIElabel(pieHandle, "SUM:  0", widthFactor / 5, backgroundActivityColor, headingTextColor);
			pieHandle.addDisplayChild(sumLabel);
			sumLabel.x = worldWidth / 2;
			sumLabel.y = 8 * worldHeight / 9;
			arc = new Vector.<PIEarc>(totalNum - 1);
			sums = new Vector.<PIElabel>(totalNum - 1);
			pieHandle.PIEresumeTimer();
		}
		
		public function startInteractive():void 
		{
			label1 = new PIElabel(pieHandle, "First Number:", widthFactor / 4, backgroundActivityColor, headingTextColor);
			pieHandle.addDisplayChild(label1);
			label1.x = worldWidth / 4;
			label1.y = worldHeight/6;
			
			label2 = new PIElabel(pieHandle, "Second Number:", widthFactor / 4, backgroundActivityColor, headingTextColor);
			pieHandle.addDisplayChild(label2);
			label2.x = worldWidth / 4;
			label2.y = 2*worldHeight / 6;
			
			instr = new PIElabel(pieHandle, "Enter num1, 0 < num1 < 10", widthFactor/4, backgroundActivityColor, headingTextColor);
			pieHandle.addDisplayChild(instr);
			
			input = new PIElabelledInput(pieHandle, "Num1: ", "", 0, 5, headingTextColor);
			input.addChangeListener(changeNumberValue);
			input.x = worldWidth - 2*widthFactor;
			input.y = worldHeight - heightFactor / 2;
			pieHandle.addDisplayChild(input);
			inumCount = 0;
		}
		
		public function changeNumberValue(num:Number):void
		{
			if (inumCount == 0 && num > 0 && num < 10)
			{
				num1 = num;
				inumCount = 1;
				numLabel1 = new PIElabel(pieHandle, num1.toString(), widthFactor / 4 , backgroundActivityColor, headingTextColor);
				pieHandle.addDisplayChild(numLabel1);
				numLabel1.x = worldWidth / 3;
				numLabel1.y = 1.5 * worldHeight / 6;
				instr.text = "Enter num2, -10<num1<0";
			}
			else if (inumCount == 1 && num < 0 && num > -10)
			{
				num2 = num;
				inumCount = 2;
				numLabel2 = new PIElabel(pieHandle, num2.toString(), widthFactor / 4 , backgroundActivityColor, headingTextColor);
				pieHandle.addDisplayChild(numLabel2);
				numLabel2.x = worldWidth / 3;
				numLabel2.y =  worldHeight / 2;
				
				sum = num1 + num2;
			
				if (num1 > num2)
				{
					left = num2;
					right = num1;
				}
				else
				{
					right = num1;
					left = num2;
				}
				numLeft = Math.abs(left);
				numRight = right + 1;
				
				totalNum = numLeft + numRight;
				number = new Vector.<PIElabel>(totalNum);
				
				var i:Number;
				var count:Number = -1;
				for (i = left; i < 0; i++)
				{
					number[++count] = new PIElabel(pieHandle, i.toString(), widthFactor/7, backgroundActivityColor, headingTextColor);
					if (count == 0)
						number[count].x = 0;
					else
						number[count].x = (count) * worldWidth / totalNum;
					number[count].y = 7 * worldHeight / 9;
					pieHandle.addDisplayChild(number[count]);
				}
				for (i = 0; i <= right; i++)
				{
					number[++count] = new PIElabel(pieHandle, i.toString(), widthFactor/7, backgroundActivityColor, headingTextColor);
					number[count].x = (count) * worldWidth / totalNum;
					number[count].y = 7 * worldHeight / 9;
					pieHandle.addDisplayChild(number[count]);
					if (i == 0)
						number[count].backgroundColor = 0XFF0000;
				}
				line = new PIEline(pieHandle, number[0].x, number[0].y + worldHeight/25, number[totalNum - 1].x, number[totalNum - 1].y + worldHeight/25, 0X55961E, worldWidth / 500, worldWidth / 500);
				pieHandle.addDisplayChild(line);
				countNum = 0;
				sumLabel = new PIElabel(pieHandle, "SUM:  0", widthFactor / 5, backgroundActivityColor, headingTextColor);
				pieHandle.addDisplayChild(sumLabel);
				sumLabel.x = worldWidth / 2;
				sumLabel.y = 8 * worldHeight / 9;
				arc = new Vector.<PIEarc>(totalNum - 1);
				sums = new Vector.<PIElabel>(totalNum - 1);
				inumCount = 3;
				pieHandle.PIEresumeTimer();
			}
		}
		
		public function startGuided():void 
		{
			
		}
		
		public function startTest():void 
		{
			
		}
		
		public function showHideButtons():void
		{
		/* implement this function to show hide buttons controls */ /* to show/hide a button use the following command */
			//doneControl.visible = true/false;
		}
		
		public function repeatButtonPressed():void
		{	
			if (mode == "demo")
			{
				startDemo();
			}
			else if (mode == "interactive")
			{
				startInteractive();
			}
			else if (mode == "guided")
			{
				startGuided();
			}
			else if (mode == "test")
			{
				startTest();
			}
			else
			{
				startDemo();
			}
		}
		
		public function stepButtonPressed():void
		{
			
		}
		
		public function autoButtonPressed():void
		{
			
		}
		
		public function doneButtonPressed():void
		{
			
		}

		/**
		 *
		 * This function is called by the PIE framework to reset the experiment to default values
		 * It defines the values of all the global (static) variables
		 *
		 */
		public function nextFrame():void
		{
			pieHandle.PIEsetDelay(500);
			if ( countNum < totalNum-1)
			{
				arc[countNum] = new PIEarc(pieHandle, (number[countNum].x +  number[countNum + 1].x) / 2 , number[0].y, number[countNum].x, number[0].y, 180,headingTextColor);
				pieHandle.addDisplayChild(arc[countNum]);
				arc[countNum].rotationZ = 180;
				//trace(parseInt(number[countNum].text))
				if (parseInt(number[countNum].text)< 0)
				{
					sumValue = sumValue - 1;
					sumLabel.text = "SUM: " + sumValue.toString();
					sums[countNum] = new PIElabel(pieHandle, sumValue.toString(), widthFactor / 8, backgroundActivityColor, headingTextColor);
					pieHandle.addDisplayChild(sums[countNum]);
					sums[countNum].x = arc[countNum].getPIEcenterX() ;
					sums[countNum].y = arc[countNum].getPIEcenterY() - (worldWidth / (2 * totalNum));
				}
				else
				{
					sumValue = sumValue + 1;
					sumLabel.text = "SUM: " + sumValue.toString();
					sums[countNum] = new PIElabel(pieHandle, sumValue.toString(), widthFactor / 8, backgroundActivityColor, headingTextColor);
					pieHandle.addDisplayChild(sums[countNum]) ;
					sums[countNum].x = arc[countNum].getPIEcenterX() ;
					sums[countNum].y = arc[countNum].getPIEcenterY() - (worldWidth / (2 * totalNum));
				}
				countNum = countNum + 1;
			}
		}
	
	}

}
