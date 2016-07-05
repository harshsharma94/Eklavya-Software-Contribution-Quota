package
{
	import flash.geom.Point;
	import pie.graphicsLibrary.*;
	import pie.uiElements.*;
	
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
		
		//colors
		private var displayBColor:uint;
		private var displayFColor:uint;
		private var UIpanelBColor:uint;
		private var UIpanelFColor:uint;
		private var controlBColor:uint;
		private var controlFColor:uint;
		private var headingTextColor:uint;
		private var backgroundActivityColor:uint;
		private var lineColor:uint = 0X347CB8;
		
		private var mode:String;
		
		private var protractorImage:PIEimage;
		
		private var rotateButtonPos:PIEbutton;
		private var rotateButtonNeg:PIEbutton;
		
		private var line1:PIEline;
		private var line2:PIEline;
		
		private var slope1:Number;
		private var slope2:Number;
		
		private var angle1:Number;
		private var angle2:Number;
		
		private var line1EndX:Number;
		private var line2EndX:Number;
		private var line1EndY:Number;
		private var line2EndY:Number;
		
		private var intersectionPointX:Number;
		private var intersectionPointY:Number;
		
		private var m:Number;
		
		private var arc:PIEarc;
		private var circle:PIEcircle;
		private var angleDisplay:PIElabel;
		
		private var maxX:Number;
		private var minX:Number;
		
		private var maxY:Number;
		private var minY:Number;
		
		private var input:PIElabelledInput;
		private var angleInput:Number;
		
		private var instr:PIElabel;
		private var clickprotractor:Number = 0;
		
		private var someDegree:Number = 0;
		private var whichLineBelow:Number = 0;
		
		private var answer:PIElabelledInput;
		private var solveAuto:Number = 0;
		private var rotate:Number = 0;
		
		private	var degrees:Number = 20;
		private var result:PIElabel;
		private var intro:PIElabel;
		
		private var resetButton:PIEbutton;
		
		
		public function Experiment(pie:PIE)
		{
			pieHandle = pie;
			
			headingTextColor = 0XBFBFBF;
			backgroundActivityColor = 0X0D0D0D;
			
			pieHandle.PIEsetDrawingArea(1.0, 1.0);
			pieHandle.PIEsetUIpanelInvisible();
			
			pieHandle.showExperimentName("Measuring Angle with protractor");
			pieHandle.showDeveloperName("Harsh Sharma");
			
			this.resetWorld();
			
			pieHandle.PIEsetDisplayColors(backgroundActivityColor, displayFColor);
			pieHandle.PIEsetUIpanelColors(UIpanelBColor, UIpanelFColor);
			
			/* load parameters */
			pieHandle.loadParameters();
			
			pieHandle.PIEcreateResetButton();
			pieHandle.ResetControl.visible = false;
			resetButton = new PIEbutton(pieHandle, "Reset");
			resetButton.x = pieHandle.ResetControl.x;
			resetButton.y = pieHandle.ResetControl.y - 5;
			resetButton.setActualSize(70, 22);
			resetButton.addClickListener(handleReset);
			resetButton.setVisible(true);
            pieHandle.addChild(resetButton);
			 
			mode = pieHandle.getParameter("mode");
			/* init a label */
			if (mode == "demo")
			{
				/* start demo mode */
				startDemo();
			}
			else if (mode == "interactive")
			{
				/* start interactive mode */
				startInteractive();
			}
			else if (mode == "guided")
			{
				/* start guided mode */
				startGuided();	
			}
			else if (mode == "test")
			{
				/* start test mode */
				startTest();
			}
			else
			{ 
				/* If no mode provided, start demo mode */
				startDemo();
			}
			
			/*
			
			*/
		}
		
		public function handleReset():void
		{
			if (line1)
				pieHandle.experimentDisplay.removeChild(line1);
				
			if (line2)
				pieHandle.experimentDisplay.removeChild(line2);
			
			if(protractorImage)
				pieHandle.experimentDisplay.removeChild(protractorImage);
			
			if (rotateButtonPos)
				pieHandle.removeChild(rotateButtonPos);
			
			if(rotateButtonNeg)
				pieHandle.removeChild(rotateButtonNeg);
			
			if (angleDisplay)
				pieHandle.experimentDisplay.removeChild(angleDisplay);

			if (input)
				pieHandle.experimentDisplay.removeChild(input);
			
			if (instr)
				pieHandle.experimentDisplay.removeChild(instr);
			
			clickprotractor = 0;
			
			someDegree = 0;
			whichLineBelow = 0;
			
			if (answer)
				pieHandle.experimentDisplay.removeChild(answer);
			solveAuto = 0;
			rotate = 0;
			
			degrees = 20;
			if (result)
				pieHandle.experimentDisplay.removeChild(result);
			if (intro)
				pieHandle.experimentDisplay.removeChild(intro);
			if (mode == "demo")
			{
				/* start demo mode */
				startDemo();
			}
			else if (mode == "interactive")
			{
				/* start interactive mode */
				startInteractive();
			}
			else if (mode == "guided")
			{
				/* start guided mode */
				startGuided();	
			}
			else if (mode == "test")
			{
				/* start test mode */
				startTest();
			}
			else
			{ 
				/* If no mode provided, start demo mode */
				startDemo();
			}
		}
		
		
		
		public function startDemo():void
		{
			pieHandle.showExperimentName("Measuring Angle with protractor(Mode: Demo)");
			
			intro =  new PIElabel(pieHandle, "An angle is the figure formed by two rays called the sides of the angle,\n" +
					"sharing a common end-point, called the vertex of the angle.\n" +
					"A protractor is a measuring instrument, typically made of transparent plastic or glass,\nfor measuring angles. The figure shown on the left is a protractor.", widthFactor / 10, backgroundActivityColor, headingTextColor);
			pieHandle.addDisplayChild(intro);
			intro.x = worldWidth / 2 - widthFactor;
			intro.y = 0;
			
			instr = new PIElabel(pieHandle, "Click protractor to align it with Intersection", widthFactor/6, backgroundActivityColor, headingTextColor);
			pieHandle.addDisplayChild(instr);
			instr.x = 0;
			instr.y = worldHeight * 0.90;

			rotateButtonPos	= new PIEbutton(pieHandle, "5 +");
			rotateButtonPos.setActualSize(worldWidth / 11, worldHeight / 12);
			rotateButtonPos.addClickListener(handleRotatePos);
			rotateButtonPos.setVisible(true);
			pieHandle.addChild(rotateButtonPos);
			rotateButtonPos.x = worldWidth-widthFactor;
			rotateButtonPos.y = worldHeight - heightFactor;
			
			rotateButtonNeg	= new PIEbutton(pieHandle, "5 -");
			rotateButtonNeg.setActualSize(worldWidth / 11, worldHeight / 12);
			rotateButtonNeg.addClickListener(handleRotateNeg);
			rotateButtonNeg.setVisible(true);
			pieHandle.addChild(rotateButtonNeg);
			rotateButtonNeg.x = worldWidth-2*widthFactor;
			rotateButtonNeg.y = worldHeight-heightFactor;
			
			protractorImage = new PIEimage(pieHandle, 0, heightFactor, 3.5*widthFactor, 3.5*heightFactor, PIEimageLocation.protractorImgPtr);
			pieHandle.addDisplayChild(protractorImage);
			protractorImage.addClickListener(handleprotractor);
			protractorImage.setPIEborder(false);
			
			intersectionPointX = worldWidth / 2;
			intersectionPointY = worldHeight / 2;
			
			minX = worldWidth/2;
			maxX = 0.95*worldWidth;
			
			minY = 100;
			maxY = 400;
			var degrees:Number = 20;
			
			while (degrees <= 20)
			{
				line1EndX = (Math.floor(Math.random() * (1 + maxX - minX)) + minX);
				line1EndY = (Math.floor(Math.random() * (1 + maxY - minY)) + minY);
				line2EndX = (Math.floor(Math.random() * (1 + maxX - minX)) + minX);
				line2EndY = (Math.floor(Math.random() * (1 + maxY - minY)) + minY);
			
				//slope1 = (line1EndY - intersectionPointY) / (line1EndX - intersectionPointX);
				//slope2 = (line2EndY - intersectionPointY) / (line2EndX - intersectionPointX);
				
				angle1 = Math.atan2((line1EndY - intersectionPointY), (line1EndX - intersectionPointX));
				angle2 = Math.atan2((line2EndY - intersectionPointY), (line2EndX - intersectionPointX));
				
				degrees = (angle2 - angle1)/Math.PI * 180;
				
				//m = (slope2 - slope1) / (1 + slope1 * slope2);
				
				//degrees = (Math.atan(m) / Math.PI) * 180;
				degrees = Math.round(degrees);
				
			}
			 
			
			/*line1EndX = 2 * worldWidth / 3;
			line1EndY = worldHeight / 3;
			line2EndX = 2 * worldWidth / 3;
			line2EndY = worldHeight/2;*/
			
			line1 = new PIEline(pieHandle, intersectionPointX, intersectionPointY, line1EndX, line1EndY, lineColor, worldWidth / 300, worldWidth / 50);
			line2 = new PIEline(pieHandle, intersectionPointX, intersectionPointY, line2EndX, line2EndY, lineColor, worldWidth / 300, worldWidth / 50);
			pieHandle.addDisplayChild(line1);
			pieHandle.addDisplayChild(line2);
			
			//var radius:Number;
			
			//radius = Math.sqrt((line1EndX - intersectionPointX) * (line1EndX - intersectionPointX) + (line1EndY - intersectionPointY) * (line1EndY - intersectionPointY));
			
			
			
			angleDisplay = new PIElabel(pieHandle,degrees.toString(), widthFactor/6, backgroundActivityColor, headingTextColor);
			pieHandle.addDisplayChild(angleDisplay);
			
			//arc = new PIEarc(pieHandle, intersectionPointX, intersectionPointY, line1EndX, line1EndY, -degrees, headingTextColor);
			//pieHandle.addDisplayChild(arc);
			
			//circle = new PIEcircle(pieHandle, intersectionPointX, intersectionPointY, radius, backgroundActivityColor);
			//circle.changeBorderColor(headingTextColor);
			//circle.changeBorderWidth(widthFactor / 100);
			
			angleDisplay.x = (line1EndX + line2EndX) / 2;
			angleDisplay.y = (line1EndY + line2EndY) / 2;
			//pieHandle.addDisplayChild(circle);
			
			//protractorImage.x = worldWidth / 2;
			//protractorImage.y = worldHeight / 2;
			
		}
		
		public function startInteractive():void
		{
			pieHandle.showExperimentName("Measuring Angle with protractor(Mode: Interactive)");
			intersectionPointX = worldWidth / 2;
			intersectionPointY = worldHeight / 2;
			
			line2EndX = 2 * worldWidth / 3;
			line2EndY = worldHeight / 2;
			
			line2 = new PIEline(pieHandle, intersectionPointX, intersectionPointY, line2EndX, line2EndY, lineColor, worldWidth / 300, worldWidth / 50);
			line2.setPIEvisible();
			pieHandle.addDisplayChild(line2);
			
			input = new PIElabelledInput(pieHandle, "Angle(deg.)", "00", 0, 5, headingTextColor);
			input.addChangeListener(changeAngleText);
			input.x = worldWidth - 2*widthFactor;
			input.y = worldHeight - heightFactor / 2;
			pieHandle.experimentDisplay.addChild(input);
			
			protractorImage = new PIEimage(pieHandle, 0, 0, 3.5*widthFactor, 3.5*heightFactor, PIEimageLocation.protractorImgPtr);
			pieHandle.addDisplayChild(protractorImage);
			protractorImage.addClickListener(handleprotractor);
			protractorImage.setPIEborder(false);
			
			instr = new PIElabel(pieHandle, "Enter the Angle Value (in deg.) in the Box shown.", widthFactor/6, backgroundActivityColor, headingTextColor);
			pieHandle.addDisplayChild(instr);
			instr.x = 0;
			instr.y = worldHeight * 0.90;
		}
		
		public function startGuided():void
		{
			pieHandle.showExperimentName("Measuring Angle with protractor(Mode: Guided)");
			rotateButtonPos	= new PIEbutton(pieHandle, "5 +");
			rotateButtonPos.setActualSize(worldWidth / 11, worldHeight / 12);
			rotateButtonPos.addClickListener(handleRotatePos);
			rotateButtonPos.setVisible(true);
			pieHandle.addChild(rotateButtonPos);
			rotateButtonPos.x = worldWidth-widthFactor;
			rotateButtonPos.y = worldHeight - heightFactor;
			
			rotateButtonNeg	= new PIEbutton(pieHandle, "5 -");
			rotateButtonNeg.setActualSize(worldWidth / 11, worldHeight / 12);
			rotateButtonNeg.addClickListener(handleRotateNeg);
			rotateButtonNeg.setVisible(true);
			pieHandle.addChild(rotateButtonNeg);
			rotateButtonNeg.x = worldWidth-2*widthFactor;
			rotateButtonNeg.y = worldHeight-heightFactor;
			
			protractorImage = new PIEimage(pieHandle, 0, 0, 3.5*widthFactor, 3.5*heightFactor, PIEimageLocation.protractorImgPtr);
			pieHandle.addDisplayChild(protractorImage);
			protractorImage.addClickListener(handleprotractor);
			protractorImage.setPIEborder(false);
			
			intersectionPointX = worldWidth / 2;
			intersectionPointY = worldHeight / 2;
			
			minX = worldWidth/2;
			maxX = 0.95*worldWidth;
			
			minY = 100;
			maxY = 400;
			var degrees:Number = 20;
			
			while (degrees <= 20)
			{
				line1EndX = (Math.floor(Math.random() * (1 + maxX - minX)) + minX);
				line1EndY = (Math.floor(Math.random() * (1 + maxY - minY)) + minY);
				line2EndX = (Math.floor(Math.random() * (1 + maxX - minX)) + minX);
				line2EndY = (Math.floor(Math.random() * (1 + maxY - minY)) + minY);
				
				angle1 = Math.atan2((line1EndY - intersectionPointY), (line1EndX - intersectionPointX));
				angle2 = Math.atan2((line2EndY - intersectionPointY), (line2EndX - intersectionPointX));
				
				degrees = (angle2 - angle1)/Math.PI * 180;
				
				degrees = Math.round(degrees);
			}
			
			line1 = new PIEline(pieHandle, intersectionPointX, intersectionPointY, line1EndX, line1EndY, lineColor, worldWidth / 300, worldWidth / 50);
			line2 = new PIEline(pieHandle, intersectionPointX, intersectionPointY, line2EndX, line2EndY, lineColor , worldWidth / 300, worldWidth / 50);
			pieHandle.addDisplayChild(line1);
			pieHandle.addDisplayChild(line2);
			
			angleDisplay = new PIElabel(pieHandle,degrees.toString(), widthFactor/6, backgroundActivityColor, headingTextColor);
			pieHandle.addDisplayChild(angleDisplay);
			
			angleDisplay.x = (line1EndX + line2EndX) / 2;
			angleDisplay.y = (line1EndY + line2EndY) / 2;
			
			if (line1EndY > line2EndY)
				whichLineBelow = 1;
			else
				whichLineBelow = 2;
				
			if (whichLineBelow == 1 && line1EndY < worldHeight / 2)
				someDegree = angle1/Math.PI*180;
			else if (whichLineBelow == 1 && line2EndY > worldHeight / 2)
				someDegree = angle1/Math.PI*180;
			else if (whichLineBelow == 2 && line2EndY < worldHeight / 2)
				someDegree = angle2/Math.PI*180;
			else
				someDegree = angle2 / Math.PI * 180;
			
			someDegree = Math.round(someDegree * 10) / 10;
			
			pieHandle.PIEresumeTimer();
		}
		
		public function startTest():void
		{
			pieHandle.showExperimentName("Measuring Angle with protractor(Mode: Test)");
			rotateButtonPos	= new PIEbutton(pieHandle, "5 +");
			rotateButtonPos.setActualSize(worldWidth / 11, worldHeight / 12);
			rotateButtonPos.addClickListener(handleRotatePos);
			rotateButtonPos.setVisible(true);
			pieHandle.addChild(rotateButtonPos);
			rotateButtonPos.x = worldWidth-widthFactor;
			rotateButtonPos.y = worldHeight - heightFactor;
			
			rotateButtonNeg	= new PIEbutton(pieHandle, " 5 -");
			rotateButtonNeg.setActualSize(worldWidth / 11, worldHeight / 12);
			rotateButtonNeg.addClickListener(handleRotateNeg);
			rotateButtonNeg.setVisible(true);
			pieHandle.addChild(rotateButtonNeg);
			rotateButtonNeg.x = worldWidth-2*widthFactor;
			rotateButtonNeg.y = worldHeight-heightFactor;
			
			protractorImage = new PIEimage(pieHandle, 0, 0, 3.5*widthFactor, 3.5*heightFactor, PIEimageLocation.protractorImgPtr);
			pieHandle.addDisplayChild(protractorImage);
			protractorImage.addClickListener(handleprotractor);
			protractorImage.setPIEborder(false);
			
			intersectionPointX = worldWidth / 2;
			intersectionPointY = worldHeight / 2;
			
			minX = worldWidth/2;
			maxX = 0.95*worldWidth;
			
			minY = 100;
			maxY = 400;
			
			while (degrees <= 20)
			{
				line1EndX = (Math.floor(Math.random() * (1 + maxX - minX)) + minX);
				line1EndY = (Math.floor(Math.random() * (1 + maxY - minY)) + minY);
				line2EndX = (Math.floor(Math.random() * (1 + maxX - minX)) + minX);
				line2EndY = (Math.floor(Math.random() * (1 + maxY - minY)) + minY);
				
				angle1 = Math.atan2((line1EndY - intersectionPointY), (line1EndX - intersectionPointX));
				angle2 = Math.atan2((line2EndY - intersectionPointY), (line2EndX - intersectionPointX));
				
				degrees = (angle2 - angle1)/Math.PI * 180;
				
				degrees = Math.round(degrees);
			}
			
			line1 = new PIEline(pieHandle, intersectionPointX, intersectionPointY, line1EndX, line1EndY, lineColor, worldWidth / 300, worldWidth / 50);
			line2 = new PIEline(pieHandle, intersectionPointX, intersectionPointY, line2EndX, line2EndY, lineColor, worldWidth / 300, worldWidth / 50);
			pieHandle.addDisplayChild(line1);
			pieHandle.addDisplayChild(line2);
			
			input = new PIElabelledInput(pieHandle, "Angle(deg.)", "00", 0, 5, headingTextColor);
			input.addChangeListener(changeAngleText);
			input.x = worldWidth - 3*widthFactor;
			input.y = worldHeight - heightFactor / 2;
			pieHandle.experimentDisplay.addChild(input);
			
			instr = new PIElabel(pieHandle, "Enter the answer(in deg.)in the Box", widthFactor/6, backgroundActivityColor, headingTextColor);
			pieHandle.addDisplayChild(instr);
			instr.x = 0;
			instr.y = worldHeight * 0.90;
			
			if (line1EndY > line2EndY)
				whichLineBelow = 1;
			else
				whichLineBelow = 2;
				
			if (whichLineBelow == 1 && line1EndY < worldHeight / 2)
				someDegree = angle1/Math.PI*180;
			else if (whichLineBelow == 1 && line2EndY > worldHeight / 2)
				someDegree = angle1/Math.PI*180;
			else if (whichLineBelow == 2 && line2EndY < worldHeight / 2)
				someDegree = angle2/Math.PI*180;
			else
				someDegree = angle2 / Math.PI * 180;
			
			someDegree = Math.round(someDegree * 10) / 10;
			
			pieHandle.PIEresumeTimer();
		}
		
		public function changeAngleText(angleText:String):void
		{
			if ((angleText.length == 2 || angleText.length == 3) && mode == "interactive")
			{
				if (line1)
					pieHandle.experimentDisplay.removeChild(line1);
				angleInput = Number(angleText);
				var len2:Number = line2EndX - intersectionPointX;
				line1EndX = intersectionPointX + len2 * Math.cos(angleInput/180*Math.PI);
				line1EndY = intersectionPointY - len2 * Math.sin(angleInput/180*Math.PI);
				
				//angleDisplay = new PIElabel(pieHandle, angleText , widthFactor/6, backgroundActivityColor, headingTextColor);
				//pieHandle.addDisplayChild(angleDisplay);
				//var tan:Number;
				//tan = Math.tan(angleInput);
				
				//line1EndX = 2 * worldWidth / 3;
				
				//var len1tan:Number = len2 * tan;
				
				//line1EndY = line2EndY - len1tan;
				
				line1 = new PIEline(pieHandle, intersectionPointX, intersectionPointY, line1EndX, line1EndY, lineColor, worldWidth / 300, worldWidth / 50);
				pieHandle.addDisplayChild(line1);
				protractorImage.x = intersectionPointX;
				protractorImage.y = intersectionPointY;
				
				if (angleDisplay)
					pieHandle.experimentDisplay.removeChild(angleDisplay);
				
				angleDisplay = new PIElabel(pieHandle, angleText, widthFactor / 6, backgroundActivityColor, headingTextColor);
				angleDisplay.x = (line1EndX + line2EndX) / 2;
				angleDisplay.y = (line1EndY + line2EndY) / 2;
				pieHandle.addDisplayChild(angleDisplay);
			}
			else if(mode=="interactive")
			{
				protractorImage.x = 1.5*widthFactor;
				protractorImage.y = 3*heightFactor;
			}
			
			if ((angleText.length == 2 || angleText.length == 3) && mode == "test")
			{
				angleInput = Number(angleText);
				if (angleInput < degrees + 4 && angleInput > degrees - 4)//Tolerance 8 Degree
				{
					if (result)
						pieHandle.experimentDisplay.removeChild(result);
					result = new PIElabel(pieHandle, "Answer within Tolerance(8 Deg.).\nCorrect Answer: " + degrees.toString(), widthFactor/6, 0X55961E, headingTextColor);
					pieHandle.addDisplayChild(result);
					result.x = 0;
					result.y = 0;
				}
				else
				{
					if (result)
						pieHandle.experimentDisplay.removeChild(result);
					result = new PIElabel(pieHandle, "Wrong Answer\nCorrect Answer: " + degrees.toString(), widthFactor/6, backgroundActivityColor, headingTextColor);
					pieHandle.addDisplayChild(result);
					result.x = 0;
					result.y = 0;
					pieHandle.PIEsetDelay(200);
					solveAuto = 1;
					protractorImage.x = widthFactor;
					protractorImage.y = 3*heightFactor;
				}
			}
		}
		
		public function handleprotractor():void
		{
			protractorImage.x = intersectionPointX;
			protractorImage.y = intersectionPointY;
			clickprotractor = 1;
		}
		
		public function handleRotatePos():void
		{
			protractorImage.rotationZ += 5;
		}
		
		public function handleRotateNeg():void
		{
			protractorImage.rotationZ -= 5;
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
		
		public function nextFrame():void
		{
			if (mode == "guided")
			{
				if (clickprotractor == 0)
				{
					instr = new PIElabel(pieHandle, "Click the protractor", widthFactor/6, backgroundActivityColor, headingTextColor);
					pieHandle.addDisplayChild(instr);
					instr.x = 0;
					instr.y = worldHeight*0.9;
				}
				if (clickprotractor == 1)
				{	
					if (whichLineBelow == 1 && line1EndY < worldHeight / 2)
					{
						instr = new PIElabel(pieHandle, "Rotate protractor by " + someDegree.toString() , widthFactor/6, backgroundActivityColor, headingTextColor);
						pieHandle.addDisplayChild(instr);
						instr.x = 0;
						instr.y = worldHeight * 0.90;
						if (someDegree > -5 && someDegree < 0)
							instr.text = "Do not Rotate"
						if (someDegree > 0 && someDegree < 5)
							instr.text = "Do not Rotate"
					}
					else if (whichLineBelow == 1 && line2EndY > worldHeight / 2)
					{
						instr = new PIElabel(pieHandle, "Rotate protractor by " + someDegree.toString() , widthFactor/6, backgroundActivityColor, headingTextColor);
						pieHandle.addDisplayChild(instr);
						instr.x = 0;
						instr.y = worldHeight * 0.90;
						if (someDegree > -5 && someDegree < 0)
							instr.text = "Do not Rotate"
						if (someDegree > 0 && someDegree < 5)
							instr.text = "Do not Rotate"
					}
					else if (whichLineBelow == 2 && line2EndY < worldHeight / 2)
					{
						instr = new PIElabel(pieHandle, "Rotate protractor by " + someDegree.toString() , widthFactor/6, backgroundActivityColor, headingTextColor);
						pieHandle.addDisplayChild(instr);
						instr.x = 0;
						instr.y = worldHeight * 0.90;
						if (someDegree > -5 && someDegree < 0)
							instr.text = "Do not Rotate"
						if (someDegree > 0 && someDegree < 5)
							instr.text = "Do not Rotate"
					}
					else
					{
						instr = new PIElabel(pieHandle, "Rotate protractor by " + someDegree.toString() , widthFactor/6, backgroundActivityColor, headingTextColor);
						pieHandle.addDisplayChild(instr);
						instr.x = 0;
						instr.y = worldHeight * 0.90;
						if (someDegree > -5 && someDegree < 0)
							instr.text = "Do not Rotate"
						if (someDegree > 0 && someDegree < 5)
							instr.text = "Do not Rotate"
					}
					
					clickprotractor = 2;
				}
				if (protractorImage.rotationZ > someDegree-5 && protractorImage.rotationZ < someDegree + 5 && clickprotractor == 2)
				{
					instr.text = "Measure the angle";
				}
			}
			
			if (mode == "test")
			{
				if (solveAuto == 1)
				{
					protractorImage.rotationZ = 0;
					if (protractorImage.x < intersectionPointX)
						protractorImage.x += worldWidth / 100;
					else
					{
						rotate = 1;
						solveAuto = 2;
						protractorImage.x = intersectionPointX;
						protractorImage.y = intersectionPointY;
						result.text = "Measure the angle";
					}
				}
				else if (rotate == 1)
				{
					if (protractorImage.rotationZ < someDegree)
						protractorImage.rotationZ += 5;
					else
					{
						protractorImage.rotationZ  = someDegree;
						angleDisplay = new PIElabel(pieHandle, degrees.toString(), widthFactor / 6, backgroundActivityColor, headingTextColor);
						angleDisplay.x = (line1EndX + line2EndX) / 2;
						angleDisplay.y = (line1EndY + line2EndY) / 2;
						pieHandle.addDisplayChild(angleDisplay);
						rotate = 2;
					}
				}
			}
		}
	}
}