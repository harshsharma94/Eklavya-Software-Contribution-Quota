package
{
	import flash.display.InteractiveObject;
	import flash.display.InterpolationMethod;
	import flash.geom.Point;
	import pie.graphicsLibrary.*;
	import pie.uiElements.*;
	import flash.display.LoaderInfo;
	
	public class Experiment
	{
		private var pieHandle:PIE;
		
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
		
		private var freqLabel:PIElabel;
		private var numSetLabel:PIElabel;
		
		private var numWord:Vector.<PIElabel>;
		private	var number:Vector.<Number>;
		private var numSet:Vector.<Number>;
		
		private var freqWord:Vector.<PIElabel>;
		private var freq:Vector.<Number>;
		private var freqSet:Vector.<Number>;
		
		private var autoFlag:Number = 0;
		private var stepFlag:Number = 0;
		
		private var indx:Number = 0;
		
		
		//private var maxNum:Number = 20;
		//private var minNum:Number = 10;
		
		private var instr:PIElabel;
		
		private var modeValue:Number;
		
		private var mode:String;
		
		private var repeatControl:PIEbutton;
		private var stepControl:PIEbutton;
		private var autoControl:PIEbutton;
		private var doneControl:PIEbutton;
		
		
		private	var max:Number;
		
		private	var mean:Number = 0;
		private	var numr:Number = 0;
		private	var denr:Number = 0;
		
		private var input:PIElabelledInput;
		private var modeInput:Number;
		private var instr1:PIElabel;
		
		private var valueEntered:Number = 0;
		
		private var totalValues:Number = 0;
		
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
			pieHandle.showExperimentName("Mode of a Set");
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
			
			/* show hide buttons according to mode */
			showHideButtons();
		
		}
		
		public function changeModeValue(modeText:String):void
		{
			if (mode == "test" && modeText.length == 2)
			{
				modeInput = parseInt(modeText);
				calcMode();
				if (modeInput == modeValue)
				{
					if (instr1)
						pieHandle.experimentDisplay.removeChild(instr1);
					instr1 = new PIElabel(pieHandle, "Correct Answer", worldWidth / 24, backgroundActivityColor, headingTextColor);
					instr1.x = 0;
					instr1.y = heightFactor/2;
					pieHandle.addDisplayChild(instr1);
					instr1.backgroundColor = 0X55961E;
				}
				else
				{
					if (instr1)
						pieHandle.experimentDisplay.removeChild(instr1);
					instr1 = new PIElabel(pieHandle, "Incorrect Answer. Mode: " + modeValue.toString(), worldWidth / 24, backgroundActivityColor, headingTextColor);
					instr1.x = 0;
					instr1.y = heightFactor/2;
					pieHandle.addDisplayChild(instr1);
					instr1.backgroundColor = 0XFF0000;
				}
			}
			else if (mode == "interactive" && modeText.length == 2)
			{
				var index:Number;
				if (totalValues < 6)
				{
					index =  totalValues++;
					number[index] = parseInt(modeText);
					numWord[index] = new PIElabel(pieHandle, number[index].toString(), worldWidth / 18, backgroundActivityColor, headingTextColor);
					numWord[index].x = (2*(index) + 1)/2 * worldWidth / 6.3;
					numWord[index].y = worldHeight / 3;
					pieHandle.addDisplayChild(numWord[index]);
					instr.text = "Enter Num" + (totalValues+1).toString() + " in input box below(Double Digit)";
				}
				else if (totalValues >= 6 && totalValues < 12)
				{
					instr.text = "Enter Freq" + (totalValues-5).toString() + " in inputbox below(Double Digit)";
					index = (totalValues++ - 6);
					freq[index] = parseInt(modeText);
					freqWord[index] = new PIElabel(pieHandle, freq[index].toString(), worldWidth / 18, backgroundActivityColor, headingTextColor);
					freqWord[index].x = (2*index + 1)/2 * worldWidth / 6.3;
					freqWord[index].y = worldHeight / 3 + heightFactor * 1.3;
					pieHandle.addDisplayChild(freqWord[index]);
					if (totalValues == 12)
					{
						calcMean();
						calcMode();
						pieHandle.experimentDisplay.removeChild(instr);
						instr = new PIElabel(pieHandle, "As Mode is the number with highest frequency.\nHighest Frequency: "
							+ max.toString() + "\nTherefore, Mode: " + modeValue.toString() + "\nMean: " + mean.toString(), worldWidth / 24, backgroundActivityColor, headingTextColor);
						instr.x = 0;
						instr.y = 0;
						pieHandle.addDisplayChild(instr);
					}
				}
			}
			else if (modeText.length == 2)
			{
				modeInput = parseInt(modeText);
				valueEntered = 1;
			}
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
			instr = new PIElabel(pieHandle, "Click Auto or Step Button", worldWidth / 24, backgroundActivityColor, headingTextColor);
			instr.x = 0;
			instr.y = 0;
			pieHandle.addDisplayChild(instr);
			
			input = new PIElabelledInput(pieHandle, "Mode: ", "", 0, 5, headingTextColor);
			input.addChangeListener(changeModeValue);
			input.x = worldWidth - 2*widthFactor;
			input.y = worldHeight - heightFactor / 2;
			pieHandle.experimentDisplay.addChild(input);
			
			number = new Vector.<Number>(6);
			numWord = new Vector.<PIElabel>(6);
			numSet = new Vector.<Number>(30);
			
			freq = new Vector.<Number>(6);
			freqWord = new Vector.<PIElabel>(6);
			freqSet = new Vector.<Number>(10);
			
			var i:Number = 0;
			var temp:Number;
			var random:Number;
			
			for (i = 0; i < numSet.length; i++)
			{
				numSet[i] = 10 + i;
			}
			
			for (i = 0; i < number.length ; i++)
			{
				//number[i] = (Math.floor(Math.random() * (1 + maxNum - minNum)) + minNum);
				random = Math.floor(Math.random() * ( numSet.length - 1))
				number[i] = numSet[random];
				temp = numSet[numSet.length - 1];
				numSet[numSet.length - 1] = numSet[random];
				numSet[random] = temp;
				numSet.pop();
			}
			
			for (i = 0; i < numWord.length; i++)
			{
				numWord[i] = new PIElabel(pieHandle, number[i].toString(), worldWidth / 18, backgroundActivityColor, headingTextColor);
				numWord[i].x = (2*i + 1)/2 * worldWidth / 6.3;
				numWord[i].y = worldHeight / 3;
				pieHandle.addDisplayChild(numWord[i]);
				numWord[i].visible = false;
			}
			
			for (i = 0; i < freqSet.length; i++)
			{
				freqSet[i] = i+1;
			}
			
			for (i = 0; i < freq.length ; i++)
			{
				//number[i] = (Math.floor(Math.random() * (1 + maxNum - minNum)) + minNum);
				random = Math.floor(Math.random() * ( freqSet.length - 1))
				freq[i] = freqSet[random];
				temp = freqSet[freqSet.length - 1];
				freqSet[freqSet.length - 1] = freqSet[random];
				freqSet[random] = temp;
				freqSet.pop();
			}
			
			for (i = 0; i < freqWord.length; i++)
			{
				freqWord[i] = new PIElabel(pieHandle, freq[i].toString(), worldWidth / 18, backgroundActivityColor, headingTextColor);
				freqWord[i].x = (2*i + 1)/2 * worldWidth / 6.3;
				freqWord[i].y = worldHeight / 3 + heightFactor * 1.3;
				pieHandle.addDisplayChild(freqWord[i]);
				freqWord[i].visible = false;
			}
			
			freqLabel = new PIElabel(pieHandle, "Frequency", worldWidth / 24, backgroundActivityColor, headingTextColor);
			freqLabel.x = 0;
			freqLabel.y = worldHeight / 3 + heightFactor/1.4;
			pieHandle.addDisplayChild(freqLabel);
			
			numSetLabel = new PIElabel(pieHandle, "Numbers", worldWidth / 24, backgroundActivityColor, headingTextColor);
			numSetLabel.x = 0;
			numSetLabel.y = worldHeight / 3 - heightFactor/1.6;
			pieHandle.addDisplayChild(numSetLabel);
			
			var lineLabel:PIElabel;
			
			var str:String = "";
			var j:Number;
			var count:Number = 0;
			var total:Number = 0;
			for (i = 0; i < freq.length; i++)
				total += freq[i];
			var allNums:Vector.<Number> = new Vector.<Number>(total);

				
			//trace(total);
			
			for (i = 0; i < 6; i++)
			{
				for (j = 0; j < freq[i]; j++)
				{
					allNums[count] = number[i];
					//str = str + number[i].toString() + ", ";
					count++;
					//if (count % 18 == 0)
						//str += "\n";
				}
			}
			
			var shuffledNums:Vector.<Number> = new Vector.<Number>(total);
			
			//trace(allNums);
			count = 0;
			while (allNums.length > 0)
			{
				shuffledNums[count++] = allNums.splice(Math.round(Math.random() * (allNums.length - 1)), 1)[0];
			}
			
			//trace(shuffledNums);
			
			//trace(str);
			
			for (i = 0 ; i < total; i++)
			{
				str = str + shuffledNums[i].toString() + ", ";
				if (i % 18 == 0 && i!=0)
				{
					str += "\n"
				}
			}
			
			lineLabel = new PIElabel(pieHandle, str,worldWidth / 30, backgroundActivityColor, headingTextColor);
			pieHandle.addDisplayChild(lineLabel);
			lineLabel.x = 0;
			lineLabel.y = 7 * worldHeight / 9;
			
			
			pieHandle.PIEresumeTimer();
		}
		
		public function startInteractive():void 
		{
			instr = new PIElabel(pieHandle, "Enter Num1 in input box below: (Double Digit)", worldWidth / 24, backgroundActivityColor, headingTextColor);
			instr.x = 0;
			instr.y = 0;
			pieHandle.addDisplayChild(instr);
			
			input = new PIElabelledInput(pieHandle, "Num: ", "", 0, 5, headingTextColor);
			input.addChangeListener(changeModeValue);
			input.x = worldWidth - 2*widthFactor;
			input.y = worldHeight - heightFactor / 2;
			pieHandle.experimentDisplay.addChild(input);
			
			number = new Vector.<Number>(6);
			numWord = new Vector.<PIElabel>(6);
			
			freq = new Vector.<Number>(6);
			freqWord = new Vector.<PIElabel>(6);
		}
		
		public function startGuided():void 
		{
			/*input = new PIElabelledInput(pieHandle, "Mode: ", "", 0, 5, headingTextColor);
			input.addChangeListener(changeModeValue);
			input.x = worldWidth - 2*widthFactor;
			input.y = worldHeight - heightFactor / 2;
			pieHandle.experimentDisplay.addChild(input);*/
			
			number = new Vector.<Number>(6);
			numWord = new Vector.<PIElabel>(6);
			numSet = new Vector.<Number>(30);
			
			freq = new Vector.<Number>(6);
			freqWord = new Vector.<PIElabel>(6);
			freqSet = new Vector.<Number>(30);
			
			var i:Number = 0;
			var temp:Number;
			var random:Number;
			
			for (i = 0; i < numSet.length; i++)
			{
				numSet[i] = 10 + i;
			}
			
			for (i = 0; i < number.length ; i++)
			{
				//number[i] = (Math.floor(Math.random() * (1 + maxNum - minNum)) + minNum);
				random = Math.floor(Math.random() * ( numSet.length - 1))
				number[i] = numSet[random];
				temp = numSet[numSet.length - 1];
				numSet[numSet.length - 1] = numSet[random];
				numSet[random] = temp;
				numSet.pop();
			}
			
			for (i = 0; i < numWord.length; i++)
			{
				numWord[i] = new PIElabel(pieHandle, number[i].toString(), worldWidth / 18, backgroundActivityColor, headingTextColor);
				numWord[i].x = (2*i + 1)/2 * worldWidth / 6.3;
				numWord[i].y = worldHeight / 3;
				pieHandle.addDisplayChild(numWord[i]);
			}
			
			for (i = 0; i < freqSet.length; i++)
			{
				freqSet[i] = i+1;
			}
			
			for (i = 0; i < freq.length ; i++)
			{
				//number[i] = (Math.floor(Math.random() * (1 + maxNum - minNum)) + minNum);
				random = Math.floor(Math.random() * ( freqSet.length - 1))
				freq[i] = freqSet[random];
				temp = freqSet[freqSet.length - 1];
				freqSet[freqSet.length - 1] = freqSet[random];
				freqSet[random] = temp;
				freqSet.pop();
			}
			
			for (i = 0; i < freqWord.length; i++)
			{
				freqWord[i] = new PIElabel(pieHandle, freq[i].toString(), worldWidth / 18, backgroundActivityColor, headingTextColor);
				freqWord[i].x = (2*i + 1)/2 * worldWidth / 6.3;
				freqWord[i].y = worldHeight / 3 + heightFactor * 1.3;
				pieHandle.addDisplayChild(freqWord[i]);
			}
			
			freqLabel = new PIElabel(pieHandle, "Frequency", worldWidth / 24, backgroundActivityColor, headingTextColor);
			freqLabel.x = 0;
			freqLabel.y = worldHeight / 3 + heightFactor/1.4;
			pieHandle.addDisplayChild(freqLabel);
			
			numSetLabel = new PIElabel(pieHandle, "Numbers", worldWidth / 24, backgroundActivityColor, headingTextColor);
			numSetLabel.x = 0;
			numSetLabel.y = worldHeight / 3 - heightFactor/1.6;
			pieHandle.addDisplayChild(numSetLabel);
			
			//pieHandle.PIEresumeTimer();
			
			calcMode();
			
			instr = new PIElabel(pieHandle, "As Mode is the number with highest frequency.\nHighest Frequency: "
					+ max.toString() + "\nTherefore, Mode: " + modeValue.toString(), worldWidth / 24, backgroundActivityColor, headingTextColor);
			instr.x = 0;
			instr.y = 4 * worldHeight / 6;
			pieHandle.addDisplayChild(instr);
		}
		
		public function startTest():void 
		{
			instr = new PIElabel(pieHandle, "Enter Mode of given numbers in input box below", worldWidth / 24, backgroundActivityColor, headingTextColor);
			instr.x = 0;
			instr.y = 0;
			pieHandle.addDisplayChild(instr);
			
			input = new PIElabelledInput(pieHandle, "Mode: ", "", 0, 5, headingTextColor);
			input.addChangeListener(changeModeValue);
			input.x = worldWidth - 2*widthFactor;
			input.y = worldHeight - heightFactor / 2;
			pieHandle.experimentDisplay.addChild(input);
			
			number = new Vector.<Number>(6);
			numWord = new Vector.<PIElabel>(6);
			numSet = new Vector.<Number>(30);
			
			freq = new Vector.<Number>(6);
			freqWord = new Vector.<PIElabel>(6);
			freqSet = new Vector.<Number>(30);
			
			var i:Number = 0;
			var temp:Number;
			var random:Number;
			
			for (i = 0; i < numSet.length; i++)
			{
				numSet[i] = 10 + i;
			}
			
			for (i = 0; i < number.length ; i++)
			{
				//number[i] = (Math.floor(Math.random() * (1 + maxNum - minNum)) + minNum);
				random = Math.floor(Math.random() * ( numSet.length - 1))
				number[i] = numSet[random];
				temp = numSet[numSet.length - 1];
				numSet[numSet.length - 1] = numSet[random];
				numSet[random] = temp;
				numSet.pop();
			}
			
			for (i = 0; i < numWord.length; i++)
			{
				numWord[i] = new PIElabel(pieHandle, number[i].toString(), worldWidth / 18, backgroundActivityColor, headingTextColor);
				numWord[i].x = (2*i + 1)/2 * worldWidth / 6.3;
				numWord[i].y = worldHeight / 3;
				pieHandle.addDisplayChild(numWord[i]);
			}
			
			for (i = 0; i < freqSet.length; i++)
			{
				freqSet[i] = i + 1;
			}
			
			for (i = 0; i < freq.length ; i++)
			{
				//number[i] = (Math.floor(Math.random() * (1 + maxNum - minNum)) + minNum);
				random = Math.floor(Math.random() * ( freqSet.length - 1))
				freq[i] = freqSet[random];
				temp = freqSet[freqSet.length - 1];
				freqSet[freqSet.length - 1] = freqSet[random];
				freqSet[random] = temp;
				freqSet.pop();
			}
			
			for (i = 0; i < freqWord.length; i++)
			{
				freqWord[i] = new PIElabel(pieHandle, freq[i].toString(), worldWidth / 18, backgroundActivityColor, headingTextColor);
				freqWord[i].x = (2*i + 1)/2 * worldWidth / 6.3;
				freqWord[i].y = worldHeight / 3 + heightFactor * 1.3;
				pieHandle.addDisplayChild(freqWord[i]);
			}
			
			freqLabel = new PIElabel(pieHandle, "Frequency", worldWidth / 24, backgroundActivityColor, headingTextColor);
			freqLabel.x = 0;
			freqLabel.y = worldHeight / 3 + heightFactor/1.4;
			pieHandle.addDisplayChild(freqLabel);
			
			numSetLabel = new PIElabel(pieHandle, "Numbers", worldWidth / 24, backgroundActivityColor, headingTextColor);
			numSetLabel.x = 0;
			numSetLabel.y = worldHeight / 3 - heightFactor/1.6;
			pieHandle.addDisplayChild(numSetLabel);
			
			//pieHandle.PIEresumeTimer();
		}
		
		public function showHideButtons():void
		{
		/* implement this function to show hide buttons controls */ /* to show/hide a button use the following command */
			//doneControl.visible = true/false;
		}
		
		public function repeatButtonPressed():void
		{
			if (instr)
				pieHandle.experimentDisplay.removeChild(instr);
			if (instr1)
				pieHandle.experimentDisplay.removeChild(instr1);
			if (input)
				pieHandle.experimentDisplay.removeChild(input);
			autoFlag = 0;
			stepFlag = 0;
			valueEntered = 0;
			totalValues = 0;
			var i:Number = 0;
			
			for ( i = 0; i < numWord.length; i++)
				if (numWord[i])
					pieHandle.experimentDisplay.removeChild(numWord[i]);
			
			for ( i = 0; i < freqWord.length; i++)
				if (freqWord[i])
					pieHandle.experimentDisplay.removeChild(freqWord[i]);
			
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
			//if(mode == "demo" || mode == null)
				stepFlag = 1;
		}
		
		public function autoButtonPressed():void
		{
			//if (mode == "demo" || mode == null)
			//{
				//autoFlag = 1;
				//instr.text = "Time Given: 15 seconds";
			//}
			if (autoFlag == 0)
			{
				autoFlag = 1;
				instr.text = "Time Given: 15 seconds";
				instr1 = new PIElabel(pieHandle, "Enter answer in Input box below", worldWidth / 24, backgroundActivityColor, headingTextColor);
				instr1.x = 0;
				instr1.y = heightFactor/2;
				pieHandle.addDisplayChild(instr1);
			}
		}
		
		public function doneButtonPressed():void
		{
			
		}
		
		public function calcMode():void
		{
			var i:Number = 0;
			var index:Number = 0;
			max = freq[i];
			for (i = 0; i < freq.length; i++)
			{
				if (max <  freq[i])
				{
					max = freq[i];
					index = i;
				}
			}
			indx = index;
			modeValue = number[index];
			if (mode == "guided" || mode == "interactive")
			{
				freqWord[index].backgroundColor = 0X55961E;
				numWord[index].backgroundColor = 0X55961E;
			}
		}
		
		public function calcMean():void
		{
			var i:Number = 0;
			
			for (i = 0; i < number.length; i++)
			{
				numr += freq[i] * number[i];
				denr += freq[i];
			}
			mean = numr / denr;
			
			mean = Math.round(mean * 100) / 100;
		}
		
		/**
		 *
		 * This function is called by the PIE framework to reset the experiment to default values
		 * It defines the values of all the global (static) variables
		 *
		 */
		public function nextFrame():void
		{
			if (autoFlag == 1 && mode != "interactive" && mode != "guided" && mode != "test")
			{
				pieHandle.PIEresumeTimer();
				autoFlag = 2;
			}
			if (autoFlag == 2 && mode != "interactive" && mode != "guided" && mode != "test")
			{
				calcMode();
				calcMean();
				var i:Number;
				
				if (modeInput == modeValue)
				{
					instr.text = "Correct Answer";
					for (i = 0; i < numWord.length; i++)
						numWord[i].visible = true;
					for ( i = 0 ; i < freqWord.length; i++)
						freqWord[i].visible = true;
					instr.backgroundColor = 0X55961E;//green
					numWord[indx].backgroundColor = 0X55961E;
					freqWord[indx].backgroundColor = 0X55961E;
					autoFlag = 3;
				}
				else if (modeInput != modeValue && valueEntered == 1)
				{
					instr.text = "Incorrect Answer";
					for (i = 0; i < numWord.length; i++)
						numWord[i].visible = true;
					for ( i = 0 ; i < freqWord.length; i++)
						freqWord[i].visible = true;
					instr.backgroundColor = 0XFF0000;//red
					instr1.text = "Mode: " + modeValue;
					instr1.y = heightFactor / 2;
					numWord[indx].backgroundColor = 0X55961E;
					freqWord[indx].backgroundColor = 0X55961E;
					autoFlag = 3;
				}
				else if (pieHandle.PIEgetTime() == 15000)
				{
					instr.text = "Mode: " + modeValue.toString() + " Mean: " + mean.toString();
					for (i = 0; i < numWord.length; i++)
						numWord[i].visible = true;
					for ( i = 0 ; i < freqWord.length; i++)
						freqWord[i].visible = true;
					
					numWord[indx].backgroundColor = 0X55961E;
					freqWord[indx].backgroundColor = 0X55961E;
					autoFlag = 3;
					pieHandle.PIEpauseTimer();
				}
			}
			if (stepFlag == 1 && mode != "interactive" && mode != "guided" && mode != "test")
			{
				calcMode();
				calcMean();
				pieHandle.experimentDisplay.removeChild(instr);
				instr = new PIElabel(pieHandle, "As Mode is the number with highest frequency.\nHighest Frequency: "
					+ max.toString() + "\nTherefore, Mode: " + modeValue.toString(), worldWidth / 24, backgroundActivityColor, headingTextColor);
				instr.x = 0;
				instr.y = 0;
				pieHandle.addDisplayChild(instr);
			}
		}
	
	}

}
