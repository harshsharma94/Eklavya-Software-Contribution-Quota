package  
{
	import flash.geom.Point;
	import flash.utils.Timer;
	import pie.graphicsLibrary.PIEcircle;
	import pie.graphicsLibrary.PIErectangle;
	import pie.graphicsLibrary.PIEroundedRectangle;
	import pie.uiElements.PIEbutton;
	import pie.uiElements.PIElabel;
	/**
	 * ...
	 * @author Harsh Sharma
	 */
	public class Experiment 
	{
		//project framework handle
		private var pieHandle:PIE;
		
		private var timerflag:int = 0;
		private var timerFlag1:int = 0;
		private var timerFlag2:int = 0;
		private var timerFlag3:int = 0;
		private var timerFlag4:int = 0;
		private var timerFlag5:int = 0;
		private var timerFlag6:int = 0;
		
		private var mytime:Number = 1000;
		
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
		private var beakerColor:uint;
		private var beakerBorder:uint;
		private var lensColor:uint;
		private var waterColor:uint;
		private var purpleColor1:uint;
		private var purpleColor2:uint;
		private var purpleColor3:uint;
		private var purpleColor4:uint;
		private var purpleColor5:uint;
		private var potassiumPermanganateColor:uint;
		
		private var borderWidth:uint;
		
		//Dimensional Parameters
		private var worldOriginX:Number;
		private var worldOriginY:Number;
		private var worldWidth:Number;
		private var worldHeight:Number;
		private var heightFactor:Number;
		private var widthFactor:Number;
		
		//beaker Parameters
		private var beakerRect1:PIEroundedRectangle;
		private var beakerRect2:PIEroundedRectangle;
		private var beakerRect3:PIEroundedRectangle;
		private var beakerRect4:PIEroundedRectangle;
		private var beakerRect5:PIEroundedRectangle;
		private var beakerCircle1:PIEcircle;
		private var beakerWaterRect1:PIEroundedRectangle;
		private var beakerMark1:PIElabel;
		private var beakerWidth:Number;
		private var beakerHeight:Number;
		private var beaker1TopX:Number;
		private var beaker1TopY:Number;
		private var beakerCircle2:PIEcircle;
		private var beakerWaterRect2:PIEroundedRectangle;
		private var beakerMark2:PIElabel;
		private var beaker2TopX:Number;
		private var beaker2TopY:Number;
		private var beakerCircle3:PIEcircle;
		private var beakerWaterRect3:PIEroundedRectangle;
		private var beakerMark3:PIElabel;
		private var beaker3TopX:Number;
		private var beaker3TopY:Number;
		private var beakerCircle4:PIEcircle;
		private var beakerWaterRect4:PIEroundedRectangle;
		private var beakerMark4:PIElabel;
		private var beaker4TopX:Number;
		private var beaker4TopY:Number;
		private var beakerCircle5:PIEcircle;
		private var beakerWaterRect5:PIEroundedRectangle;
		private var beakerMark5:PIElabel;
		private var beaker5TopX:Number;
		private var beaker5TopY:Number;
		
		private var testTubeSolnRect:PIErectangle;
		private var testTubeMark:PIElabel;		
		private var potassiumPermanganateCrystal:PIEroundedRectangle;
		private var potassiumPermanganateCrystal1:PIEroundedRectangle;
		private var clickCrystal:Number;
		private var clickBeaker1:Number;
		private var clickBeaker2:Number;
		private var clickBeaker3:Number;
		private var clickBeaker4:Number;
		private var clickBeaker5:Number;
		private var dragTestTube2:Number;
		private var dragTestTube3:Number;
		private var dragTestTube4:Number;
		private var dragTestTube5:Number;
		
		private var solnTransferred1:Number;
		private var solnTransferred2:Number;
		private var solnTransferred3:Number;
		private var solnTransferred4:Number;
		
		private var circle:PIEcircle;
		
		private var instrLabel:PIElabel;
		
		private var currentTime:Number;
		
		private var resetButton:PIEbutton;
		
		//test tube
		private var testTubeRect:PIEroundedRectangle;
		
		
		public function Experiment(pie:PIE) 
		{
			pieHandle = pie;
			
			pieHandle.PIEsetDrawingArea(1.0, 1.0);
			pieHandle.PIEsetUIpanelInvisible();
			
			pieHandle.PIEcreateResetButton();
			pieHandle.ResetControl.visible = false;
			resetButton = new PIEbutton(pieHandle, "Reset");
			resetButton.x = pieHandle.ResetControl.x;
			resetButton.y = pieHandle.ResetControl.y - 5;
			resetButton.setActualSize(70, 22);
			resetButton.addClickListener(handleReset);
			resetButton.setVisible(true);
            pieHandle.addChild(resetButton);
			
			this.setColor();
			this.resetWorld();
			
			pieHandle.PIEresumeTimer();
			
			widthFactor = worldWidth / 6;
			heightFactor = worldHeight / 12;
			beakerWidth = worldWidth / 10;
			beakerHeight = worldHeight / 5;
			beaker1TopX = worldWidth/10 - widthFactor/5;
			beaker1TopY = 2 * worldHeight / 3 + heightFactor;
			beaker2TopX = 3 * worldWidth / 10 - widthFactor/5;
			beaker2TopY = 2 * worldHeight / 3 + heightFactor;
			beaker3TopX = 5 * worldWidth / 10 - widthFactor/5;
			beaker3TopY = 2 * worldHeight / 3 + heightFactor;
			beaker4TopX = 7 * worldWidth / 10 - widthFactor/5;
			beaker4TopY = 2 * worldHeight / 3 + heightFactor;
			beaker5TopX = 9 * worldWidth / 10 - widthFactor/3.9;
			beaker5TopY = 2 * worldHeight / 3 + heightFactor;
			
			clickCrystal = 0;
			clickBeaker1 = 0;
			clickBeaker2 = 0;
			clickBeaker3 = 0;
			clickBeaker4 = 0;
			clickBeaker5 = 0;
			dragTestTube2 = 0;
			dragTestTube3 = 0;
			dragTestTube4 = 0;
			dragTestTube5 = 0;
			
			solnTransferred1 = 0;
			solnTransferred2 = 0;
			solnTransferred3 = 0;
			solnTransferred4 = 0;
			
			borderWidth =  worldWidth / 450;
			
			instrLabel = new PIElabel(pieHandle, "Click the Bigger Crystal", worldWidth / 23, backgroundActivityColor, headingTextColor);
			instrLabel.background = false;
			instrLabel.setLabelUnderline(true);
			instrLabel.text = "Click the Bigger Crystal";
			pieHandle.addDisplayChild(instrLabel);
			instrLabel.x = worldWidth / 3;
			
			this.setupBeaker1();
			this.setupBeaker2();
			this.setupBeaker3();
			this.setupBeaker4();
			this.setupBeaker5();
			
			testTubeRect = new PIEroundedRectangle(pieHandle, worldWidth / 2.3, worldHeight / 1.7, worldWidth / 150, worldHeight / 6, lensColor);
			pieHandle.addDisplayChild(testTubeRect);
			testTubeRect.addDragAndDropListeners(aGrab, aDrag, aDrop);
			
			circle = new PIEcircle(pieHandle, 1.25 * worldWidth / 10, worldHeight / 2.8, heightFactor / 2, lensColor);
			circle.rotationX = 75;
			circle.rotationZ = -5;
			circle.setPIEborder(true);
			circle.changeBorderColor(beakerBorder);
			pieHandle.addDisplayChild(circle);
			
			potassiumPermanganateCrystal = new PIEroundedRectangle(pieHandle, 1.25*worldWidth / 10, worldHeight / 3, 1.75*worldWidth / 100 , 1.75*worldWidth / 100, potassiumPermanganateColor);
			pieHandle.addDisplayChild(potassiumPermanganateCrystal);
			potassiumPermanganateCrystal.addClickListener(handleCrystal);
			
			potassiumPermanganateCrystal1 = new PIEroundedRectangle(pieHandle, 1.25*worldWidth / 10 - widthFactor/10, worldHeight / 3, worldWidth / 100, worldWidth / 100, potassiumPermanganateColor);
			pieHandle.addDisplayChild(potassiumPermanganateCrystal1);
			
			pieHandle.showExperimentName("How Small are the Particles of Matter ?");
			pieHandle.showDeveloperName("Harsh Sharma");
			
		}
		
		public function handleReset():void
		{
			pieHandle.PIEpauseTimer();
			if (instrLabel)
			{
				pieHandle.experimentDisplay.removeChild(instrLabel);//trace("working");
			}
			
			if (beakerRect1)
			{
				pieHandle.experimentDisplay.removeChild(beakerRect1);//trace("working");
			}
			if (beakerRect2)
			{
				pieHandle.experimentDisplay.removeChild(beakerRect2);//trace("working");
			}
			if (beakerRect3)
			{
				pieHandle.experimentDisplay.removeChild(beakerRect3);//trace("working");
			}
			if (beakerRect4)
			{
				pieHandle.experimentDisplay.removeChild(beakerRect4);//trace("working");
			}
			if (beakerRect5)
			{
				pieHandle.experimentDisplay.removeChild(beakerRect5);//trace("working");
			}
			if (testTubeRect)
			{
				pieHandle.experimentDisplay.removeChild(testTubeRect);//trace("working");
			}
			if (potassiumPermanganateCrystal)
			{
				pieHandle.experimentDisplay.removeChild(potassiumPermanganateCrystal);//trace("working");
			}
			clickCrystal = 0;
			clickBeaker1 = 0;
			clickBeaker2 = 0;
			clickBeaker3 = 0;
			clickBeaker4 = 0;
			clickBeaker5 = 0;
			dragTestTube2 = 0;
			dragTestTube3 = 0;
			dragTestTube4 = 0;
			dragTestTube5 = 0;
			
			solnTransferred1 = 0;
			solnTransferred2 = 0;
			solnTransferred3 = 0;
			solnTransferred4 = 0;
			
			instrLabel = new PIElabel(pieHandle, "Click the Bigger Crystal", worldWidth / 23, backgroundActivityColor, headingTextColor);
			instrLabel.background = false;
			instrLabel.setLabelUnderline(true);
			instrLabel.text = "Click the Bigger Crystal";
			pieHandle.addDisplayChild(instrLabel);
			instrLabel.x = worldWidth / 3;
			
			this.setupBeaker1();
			this.setupBeaker2();
			this.setupBeaker3();
			this.setupBeaker4();
			this.setupBeaker5();
			
			potassiumPermanganateCrystal = new PIEroundedRectangle(pieHandle, 1.25*worldWidth / 10, worldHeight / 3, 1.75*worldWidth / 100 , 1.75*worldWidth / 100, potassiumPermanganateColor);
			pieHandle.addDisplayChild(potassiumPermanganateCrystal);
			potassiumPermanganateCrystal.addClickListener(handleCrystal);
			
			testTubeRect = new PIEroundedRectangle(pieHandle, worldWidth / 2.3, worldHeight / 1.7, worldWidth / 150, worldHeight / 6, lensColor);
			pieHandle.addDisplayChild(testTubeRect);
			testTubeRect.addDragAndDropListeners(aGrab, aDrag, aDrop);
			
			pieHandle.PIEresetTimer();
			pieHandle.PIEresumeTimer();
		}
		
		public function nextFrame():void
		{
			pieHandle.PIEsetDelay(35);
			if (clickCrystal == 1)
				//if (pieHandle.PIEgetTime() % 100 == 0)
				if (potassiumPermanganateCrystal.y < beakerRect1.y)
				{
					potassiumPermanganateCrystal.y += potassiumPermanganateCrystal.width;
				}
				else
				{
					potassiumPermanganateCrystal.setPIEinvisible();
					beakerWaterRect1.changeFillColor(purpleColor1);
					clickCrystal = 0;
					pieHandle.experimentDisplay.removeChild(instrLabel);
					instrLabel = new PIElabel(pieHandle, "Click the Solution in Beaker 1", worldWidth / 20, backgroundActivityColor, headingTextColor);
					instrLabel.background = false;
					instrLabel.setLabelUnderline(true);
					instrLabel.text = "Click the Solution in Beaker 1";
					pieHandle.addDisplayChild(instrLabel);
					instrLabel.x = worldWidth / 6;
				}
			if (clickBeaker1 == 1)
			{
				if (beakerRect1.x < testTubeRect.x-worldWidth/15 )
				{
					beakerRect1.x += worldWidth / 100;
					beakerRect1.y -= worldHeight / 100;
				}
				else
				{
					beakerRect1.rotationZ = 45;
					clickBeaker1 = 0;
					solnTransferred1 = 1;
					testTubeSolnRect = new PIErectangle(pieHandle, 0-testTubeRect.width/2, 0, testTubeRect.width, testTubeRect.height/2, purpleColor1);
					testTubeRect.addChild(testTubeSolnRect);
					beakerMark1.text = "-90ml";
					testTubeMark = new PIElabel(pieHandle, "-10ml", worldWidth / 60, backgroundActivityColor, headingTextColor);
					testTubeRect.addChild(testTubeMark);
					testTubeMark.background = false;
					testTubeMark.x = testTubeRect.width / 20;
					testTubeMark.y = -testTubeRect.height / 7.5
					
					pieHandle.experimentDisplay.removeChild(instrLabel);
					instrLabel = new PIElabel(pieHandle, "Drag the Test Tube to a position above Beaker 2", worldWidth / 30, backgroundActivityColor, headingTextColor);
					instrLabel.background = false;
					instrLabel.setLabelUnderline(true);
					instrLabel.text = "Drag the Test Tube to a position above Beaker 2";
					pieHandle.addDisplayChild(instrLabel);
					instrLabel.x = worldWidth / 6;
				}
			}
			if (solnTransferred1 == 1 && beakerRect1.x > 1.5*widthFactor)
			{
				beakerRect1.x -= worldWidth / 100;
			}
			else if(solnTransferred1==1)
			{
				beakerRect1.setPIEinvisible();
				beakerWaterRect1.setPIEinvisible();
				beakerMark1.visible = false;
				beakerCircle1.setPIEinvisible();
				solnTransferred1 = 0;
				setupBeaker1();
				beakerWaterRect1.changeFillColor(purpleColor1);
				beakerMark1.text = "-90ml";
			}
			
			if (dragTestTube2 == 1)
			{
				testTubeRect.rotationZ = 45;
				testTubeSolnRect.setPIEinvisible();
				beakerWaterRect2.changeFillColor(purpleColor2);
				beakerRect2.removeChild(beakerMark2);
				
				beakerMark2 =  new PIElabel(pieHandle, "-100ml", worldWidth / 60, backgroundActivityColor, headingTextColor);
				beakerMark2.background = false;
				beakerRect2.addChild(beakerMark2);
				beakerMark2.x = 0 + beakerWidth / 2;
				beakerMark2.y = -beakerHeight / 7.5;
				
				if (timerflag == 0) {
					//pieHandle.PIEpauseTimer();
				pieHandle.PIEsetTime(0.0);
				//pieHandle.PIEresumeTimer();
				timerflag = 1;
				}
				else{
				currentTime = pieHandle.PIEgetTime();
				if (currentTime > mytime)
				{
					testTubeRect.rotationZ = 0;
					dragTestTube2 = 0;
					testTubeRect.x = worldWidth / 2.3;
					testTubeRect.y = worldHeight / 1.7;
				}
				}
				pieHandle.experimentDisplay.removeChild(instrLabel);
				instrLabel = new PIElabel(pieHandle, "Click the Solution in Beaker 2", worldWidth / 20, backgroundActivityColor, headingTextColor);
				instrLabel.setLabelUnderline(true);
				instrLabel.text = "Click the Solution in Beaker 2";
				instrLabel.background = false;
				pieHandle.addDisplayChild(instrLabel);
				instrLabel.x = worldWidth / 6;
			}
			
			if (clickBeaker2 == 1)
			{
				if (beakerRect2.y > testTubeRect.y - beakerHeight/2 )
				{
					beakerRect2.y -= worldHeight / 100;
				}
				else
				{
					beakerRect2.rotationZ = 45;
					clickBeaker2 = 0;
					//solnTransferred1 = 1;
					pieHandle.experimentDisplay.removeChild(testTubeRect);
					testTubeRect = new PIEroundedRectangle(pieHandle, worldWidth / 2.3, worldHeight / 1.7, worldWidth / 150, worldHeight / 6, lensColor);
					pieHandle.addDisplayChild(testTubeRect);
					testTubeRect.addDragAndDropListeners(aGrab, aDrag, aDrop);
					
					testTubeSolnRect = new PIErectangle(pieHandle, 0-testTubeRect.width/2, 0, testTubeRect.width, testTubeRect.height/2, purpleColor2);
					testTubeRect.addChild(testTubeSolnRect);
					beakerMark2.text = "-90ml";
					
					testTubeMark = new PIElabel(pieHandle, "-10ml", worldWidth / 60, backgroundActivityColor, headingTextColor);
					testTubeRect.addChild(testTubeMark);
					testTubeMark.background = false;
					testTubeMark.x = testTubeRect.width / 20;
					testTubeMark.y = -testTubeRect.height / 7.5
					
					pieHandle.experimentDisplay.removeChild(instrLabel);
					instrLabel = new PIElabel(pieHandle, "Drag the Test Tube to a position above Beaker 3", worldWidth / 30, backgroundActivityColor, headingTextColor);
					instrLabel.background = false;
					instrLabel.setLabelUnderline(true);
					instrLabel.text = "Drag the Test Tube to a position above Beaker 3";
					pieHandle.addDisplayChild(instrLabel);
					instrLabel.x = worldWidth / 6;
					
					solnTransferred2 = 1;
					
					if (timerFlag1 == 0)
					{
						pieHandle.PIEsetTime(0.0);
						timerFlag1 = 1;
					}
					else
					{
						currentTime = pieHandle.PIEgetTime();
						if (currentTime > mytime)
						{
							beakerRect2.rotationZ = 0;
						}
					}
				}
			}
			
			if (solnTransferred2 == 1 && beakerRect2.y < 2 * worldHeight / 3 + heightFactor)
			{
				beakerRect2.y += worldHeight / 100;
			}
			else if (solnTransferred2 == 1)
			{
				pieHandle.experimentDisplay.removeChild(beakerRect2);
				setupBeaker2();
				beakerWaterRect2.changeFillColor(purpleColor2);
				beakerMark2.text = "-90ml";
				solnTransferred2 = 0;
			}
			
			if (dragTestTube3 == 1)
			{
				testTubeRect.rotationZ = 45;
				testTubeSolnRect.setPIEinvisible();
				beakerWaterRect3.changeFillColor(purpleColor3);
				beakerRect3.removeChild(beakerMark3);
				
				beakerMark3 =  new PIElabel(pieHandle, "-100ml", worldWidth / 60, backgroundActivityColor, headingTextColor);
				beakerMark3.background = false;
				beakerRect3.addChild(beakerMark3);
				beakerMark3.x = 0 + beakerWidth / 2;
				beakerMark3.y = -beakerHeight / 7.5;
				
				if (timerFlag2 == 0) 
				{
					pieHandle.PIEsetTime(0.0);
					timerFlag2 = 1;
				}
				else
				{
					currentTime = pieHandle.PIEgetTime();
					if (currentTime > mytime)
					{
						testTubeRect.rotationZ = 0;
						dragTestTube3 = 0;
						testTubeRect.x = worldWidth / 2.3;
						testTubeRect.y = worldHeight / 1.7;
					}
				}
				pieHandle.experimentDisplay.removeChild(instrLabel);
				instrLabel = new PIElabel(pieHandle, "Click the Solution in Beaker 3", worldWidth / 20, backgroundActivityColor, headingTextColor);
				instrLabel.background = false;
				instrLabel.setLabelUnderline(true);
				instrLabel.text = "Click the Solution in Beaker 3";
				pieHandle.addDisplayChild(instrLabel);
				instrLabel.x = worldWidth / 6;
			}
			
			if (clickBeaker3 == 1)
			{
				if (beakerRect3.y > testTubeRect.y - beakerHeight/2 )
				{
					beakerRect3.y -= worldHeight / 100;
				}
				else
				{
					beakerRect3.rotationZ = -45;
					clickBeaker3 = 0;
					//solnTransferred1 = 1;
					pieHandle.experimentDisplay.removeChild(testTubeRect);
					testTubeRect = new PIEroundedRectangle(pieHandle, worldWidth / 2.3, worldHeight / 1.7, worldWidth / 150, worldHeight / 6, lensColor);
					pieHandle.addDisplayChild(testTubeRect);
					testTubeRect.addDragAndDropListeners(aGrab, aDrag, aDrop);
					
					testTubeSolnRect = new PIErectangle(pieHandle, 0-testTubeRect.width/2, 0, testTubeRect.width, testTubeRect.height/2, purpleColor3);
					testTubeRect.addChild(testTubeSolnRect);
					beakerRect3.removeChild(beakerMark3);
					
					beakerMark3 =  new PIElabel(pieHandle, "-90ml", worldWidth / 60, backgroundActivityColor, headingTextColor);
					beakerMark3.background = false;
					beakerRect3.addChild(beakerMark3);
					beakerMark3.x = 0 + beakerWidth / 2;
					beakerMark3.y = -beakerHeight / 7.5;
					
					testTubeMark = new PIElabel(pieHandle, "-10ml", worldWidth / 60, backgroundActivityColor, headingTextColor);
					testTubeRect.addChild(testTubeMark);
					testTubeMark.background = false;
					testTubeMark.x = testTubeRect.width / 20;
					testTubeMark.y = -testTubeRect.height / 7.5
					
					pieHandle.experimentDisplay.removeChild(instrLabel);
					instrLabel = new PIElabel(pieHandle, "Drag the Test Tube to a position above Beaker 4", worldWidth / 30, backgroundActivityColor, headingTextColor);
					instrLabel.background = false;
					instrLabel.setLabelUnderline(true);
					instrLabel.text = "Drag the Test Tube to a position above Beaker 4";
					pieHandle.addDisplayChild(instrLabel);
					instrLabel.x = worldWidth / 6;
					
					solnTransferred3 = 1;
					
					if (timerFlag3 == 0)
					{
						pieHandle.PIEsetTime(0.0);
						timerFlag3 = 1;
					}
					else
					{
						currentTime = pieHandle.PIEgetTime();
						if (currentTime > mytime)
						{
							beakerRect3.rotationZ = 0;
						}
					}
				}
			}
			
			if (solnTransferred3 == 1 && beakerRect3.y < 2 * worldHeight / 3 + heightFactor)
			{
				beakerRect3.y += worldHeight / 100;
			}
			else if (solnTransferred3 == 1)
			{
				pieHandle.experimentDisplay.removeChild(beakerRect3);
				setupBeaker3();
				beakerWaterRect3.changeFillColor(purpleColor3);
				beakerRect3.removeChild(beakerMark3);
				solnTransferred3 = 0;
				testTubeRect.x += widthFactor;
				
				beakerMark3 =  new PIElabel(pieHandle, "-90ml", worldWidth / 60, backgroundActivityColor, headingTextColor);
				beakerMark3.background = false;
				beakerRect3.addChild(beakerMark3);
				beakerMark3.x = 0 + beakerWidth / 2;
				beakerMark3.y = -beakerHeight / 7.5;
			}
			
			if (dragTestTube4 == 1)
			{
				testTubeRect.rotationZ = 45;
				testTubeSolnRect.setPIEinvisible();
				beakerWaterRect4.changeFillColor(purpleColor4);
				beakerRect4.removeChild(beakerMark4);
				
				beakerMark4 =  new PIElabel(pieHandle, "-100ml", worldWidth / 60, backgroundActivityColor, headingTextColor);
				beakerMark4.background = false;
				beakerRect4.addChild(beakerMark4);
				beakerMark4.x = 0 + beakerWidth / 2;
				beakerMark4.y = -beakerHeight / 7.5;
				
				if (timerFlag4 == 0) 
				{
					pieHandle.PIEsetTime(0.0);
					timerFlag4 = 1;
				}
				else
				{
					currentTime = pieHandle.PIEgetTime();
					if (currentTime > mytime)
					{
						testTubeRect.rotationZ = 0;
						dragTestTube4 = 0;
						testTubeRect.x = worldWidth / 2.3;
						testTubeRect.y = worldHeight / 1.7;
						testTubeRect.x += 2.3 * widthFactor;
					}
				}
				pieHandle.experimentDisplay.removeChild(instrLabel);
				instrLabel = new PIElabel(pieHandle, "Click the Solution in Beaker 4", worldWidth / 20, backgroundActivityColor, headingTextColor);
				instrLabel.background = false;
				instrLabel.setLabelUnderline(true);
				instrLabel.text = "Click the Solution in Beaker 4";
				pieHandle.addDisplayChild(instrLabel);
				instrLabel.x = worldWidth / 6;
			}
			
			if (clickBeaker4 == 1)
			{
				if (beakerRect4.y > testTubeRect.y - beakerHeight/2 )
				{
					beakerRect4.y -= worldHeight / 100;
				}
				else
				{
					beakerRect4.rotationZ = 45;
					clickBeaker4 = 0;
					//solnTransferred1 = 1;
					pieHandle.experimentDisplay.removeChild(testTubeRect);
					testTubeRect = new PIEroundedRectangle(pieHandle, worldWidth / 2.3, worldHeight / 1.7, worldWidth / 150, worldHeight / 6, lensColor);
					pieHandle.addDisplayChild(testTubeRect);
					testTubeRect.addDragAndDropListeners(aGrab, aDrag, aDrop);
					testTubeRect.x = worldWidth/2.3 + 2.3 * widthFactor;
					
					testTubeSolnRect = new PIErectangle(pieHandle, 0-testTubeRect.width/2, 0, testTubeRect.width, testTubeRect.height/2, purpleColor4);
					testTubeRect.addChild(testTubeSolnRect);
					beakerRect4.removeChild(beakerMark4);
					
					beakerMark4 =  new PIElabel(pieHandle, "-90ml", worldWidth / 60, backgroundActivityColor, headingTextColor);
					beakerMark4.background = false;
					beakerRect4.addChild(beakerMark4);
					beakerMark4.x = 0 + beakerWidth / 2;
					beakerMark4.y = -beakerHeight / 7.5;
					
					testTubeMark = new PIElabel(pieHandle, "-10ml", worldWidth / 60, backgroundActivityColor, headingTextColor);
					testTubeRect.addChild(testTubeMark);
					testTubeMark.background = false;
					testTubeMark.x = testTubeRect.width / 20;
					testTubeMark.y = -testTubeRect.height / 7.5
					
					pieHandle.experimentDisplay.removeChild(instrLabel);
					instrLabel = new PIElabel(pieHandle, "Drag the Test Tube to a position above Beaker 5", worldWidth / 30, backgroundActivityColor, headingTextColor);
					instrLabel.background = false;
					instrLabel.setLabelUnderline(true);
					instrLabel.text = "Drag the Test Tube to a position above Beaker 5";
					pieHandle.addDisplayChild(instrLabel);
					instrLabel.x = worldWidth / 6;
					
					solnTransferred4 = 1;
					
					if (timerFlag5 == 0)
					{
						pieHandle.PIEsetTime(0.0);
						timerFlag5 = 1;
					}
					else
					{
						currentTime = pieHandle.PIEgetTime();
						if (currentTime > mytime)
						{
							beakerRect4.rotationZ = 0;
						}
					}
				}
			}
			
			if (solnTransferred4 == 1 && beakerRect4.y < 2 * worldHeight / 3 + heightFactor)
			{
				beakerRect4.y += worldHeight / 100;
			}
			else if (solnTransferred4 == 1)
			{
				pieHandle.experimentDisplay.removeChild(beakerRect4);
				setupBeaker4();
				beakerWaterRect4.changeFillColor(purpleColor4);
				beakerRect4.removeChild(beakerMark4);
				solnTransferred4 = 0;
				
				beakerMark4 =  new PIElabel(pieHandle, "-90ml", worldWidth / 60, backgroundActivityColor, headingTextColor);
				beakerMark4.background = false;
				beakerRect4.addChild(beakerMark4);
				beakerMark4.x = 0 + beakerWidth / 2;
				beakerMark4.y = -beakerHeight / 7.5;
			}
			
			if (dragTestTube5 == 1)
			{
				testTubeRect.rotationZ = -45;
				testTubeSolnRect.setPIEinvisible();
				beakerWaterRect5.changeFillColor(purpleColor5);
				beakerRect5.removeChild(beakerMark5);
				
				beakerMark5 =  new PIElabel(pieHandle, "-100ml", worldWidth / 60, backgroundActivityColor, headingTextColor);
				beakerMark5.background = false;
				beakerRect5.addChild(beakerMark5);
				beakerMark5.x = 0 + beakerWidth / 2;
				beakerMark5.y = -beakerHeight / 7.5;
				
				if (timerFlag6 == 0) 
				{
					pieHandle.PIEsetTime(0.0);
					timerFlag6 = 1;
				}
				else
				{
					currentTime = pieHandle.PIEgetTime();
					if (currentTime > mytime)
					{
						testTubeRect.rotationZ = 0;
						dragTestTube5 = 0;
						testTubeRect.x = worldWidth / 2.3;
						testTubeRect.y = worldHeight / 1.7;
					}
				}
				pieHandle.experimentDisplay.removeChild(instrLabel);
				instrLabel = new PIElabel(pieHandle, "Millions of Tiny Particles are there in just One Crystal of Potassium Permanganate,\n"
						+ "which keep dividing themselves into smaller and smaller particles" 
						+".\nUltimately a stage is reached, when the particles cannot divide further into smaller particles.", worldWidth / 40, backgroundActivityColor, headingTextColor);
				instrLabel.background = false;
				instrLabel.setLabelUnderline(true);
				instrLabel.text = "Millions of Tiny Particles are there in just One Crystal of Potassium Permanganate,\n"
						+ "which keep dividing themselves into smaller and smaller particles" 
						+".\nUltimately a stage is reached, when the particles cannot divide further into smaller particles.";
				
				pieHandle.addDisplayChild(instrLabel);
				instrLabel.x = 0;
			}
			
			
			
		}
		
		public function setupBeaker1():void
		{
			beakerRect1 = new PIEroundedRectangle(pieHandle, beaker1TopX, beaker1TopY, beakerWidth, beakerHeight, lensColor);
			pieHandle.addDisplayChild(beakerRect1);
			beakerRect1.setPIEborder(true);
			beakerRect1.addDefaultDragAction(null, null);
			beakerRect1.changeBorderColor(beakerBorder);
			beakerRect1.changeBorderWidth(borderWidth);
			
			//beakerCircle1 = new PIEcircle(pieHandle, beakerRect1.x , beakerRect1.y - beakerRect1.height / 2 , beakerRect1.width / 2, lensColor);
			beakerCircle1 = new PIEcircle(pieHandle, 0, -beakerHeight / 2, beakerWidth / 2, lensColor);
			beakerRect1.addChild(beakerCircle1);
			beakerCircle1.changeBorder(borderWidth*4, beakerBorder, 100);
			beakerCircle1.rotationX = 75;
			
			//beakerWaterRect1 = new PIEroundedRectangle(pieHandle, beakerRect1.x - beakerRect1.width / 2, beakerRect1.y, beakerRect1.width - 2 * beakerRect1.getBorderWidth(),
					//beakerRect1.height / 2-2*beakerRect1.getBorderWidth(), waterColor);
					
			beakerWaterRect1 = new PIEroundedRectangle(pieHandle, 0-beakerWidth/2, 0, beakerWidth, beakerHeight / 2, waterColor);
			beakerRect1.addChild(beakerWaterRect1);
			beakerWaterRect1.addClickListener(handleBeaker1);
			
			beakerMark1 =  new PIElabel(pieHandle, "-100ml", worldWidth / 60, backgroundActivityColor, headingTextColor);
			beakerMark1.background = false;
			beakerRect1.addChild(beakerMark1);
			beakerMark1.x = 0 + beakerWidth / 2;
			beakerMark1.y = -beakerHeight / 7.5;
		}
		
		public function setupBeaker2():void
		{
			beakerRect2 = new PIEroundedRectangle(pieHandle, beaker2TopX, beaker2TopY, beakerWidth, beakerHeight, lensColor);
			pieHandle.addDisplayChild(beakerRect2);
			beakerRect2.setPIEborder(true);
			beakerRect2.addDefaultDragAction(null, null);
			beakerRect2.changeBorderColor(beakerBorder);
			beakerRect2.changeBorderWidth(borderWidth);

			
			beakerCircle2 = new PIEcircle(pieHandle, 0, -beakerHeight / 2, beakerWidth / 2, lensColor);
			beakerRect2.addChild(beakerCircle2);
			beakerCircle2.changeBorder(borderWidth*4,beakerBorder, 100);
			beakerCircle2.rotationX = 75;
			
					
			beakerWaterRect2 = new PIEroundedRectangle(pieHandle, 0-beakerWidth/2, 0, beakerWidth, beakerHeight / 2, waterColor);
			beakerRect2.addChild(beakerWaterRect2);
			beakerWaterRect2.addClickListener(handleBeaker2);
			
			beakerMark2 =  new PIElabel(pieHandle, "-90ml", worldWidth / 60, backgroundActivityColor, headingTextColor);
			beakerMark2.background = false;
			beakerRect2.addChild(beakerMark2);
			beakerMark2.x = 0 + beakerWidth / 2;
			beakerMark2.y = -beakerHeight / 7.5;
		}
		
		public function setupBeaker3():void
		{
			beakerRect3 = new PIEroundedRectangle(pieHandle, beaker3TopX, beaker3TopY, beakerWidth, beakerHeight, lensColor);
			pieHandle.addDisplayChild(beakerRect3);
			beakerRect3.setPIEborder(true);
			beakerRect3.addDefaultDragAction(null, null);
			beakerRect3.changeBorderColor(beakerBorder);
			beakerRect3.changeBorderWidth(borderWidth);

			
			beakerCircle3 = new PIEcircle(pieHandle, 0, -beakerHeight / 2, beakerWidth / 2, lensColor);
			beakerRect3.addChild(beakerCircle3);
			beakerCircle3.changeBorder(borderWidth*4,beakerBorder, 100);
			beakerCircle3.rotationX = 75;
			
			beakerWaterRect3 = new PIEroundedRectangle(pieHandle, 0-beakerWidth/2, 0, beakerWidth, beakerHeight / 2, waterColor);
			beakerRect3.addChild(beakerWaterRect3);
			beakerWaterRect3.addClickListener(handleBeaker3);
			
			beakerMark3 =  new PIElabel(pieHandle, "-90ml", worldWidth / 60, backgroundActivityColor, headingTextColor);
			beakerMark3.background = false;
			beakerRect3.addChild(beakerMark3);
			beakerMark3.x = 0 + beakerWidth / 2;
			beakerMark3.y = -beakerHeight / 7.5;
		}
		
		public function setupBeaker4():void
		{
			beakerRect4 = new PIEroundedRectangle(pieHandle, beaker4TopX, beaker4TopY, beakerWidth, beakerHeight, lensColor);
			pieHandle.addDisplayChild(beakerRect4);
			beakerRect4.setPIEborder(true);
			beakerRect4.addDefaultDragAction(null, null);
			beakerRect4.changeBorderColor(beakerBorder);
			beakerRect1.changeBorderWidth(borderWidth);

			
			beakerCircle4 = new PIEcircle(pieHandle, 0, -beakerHeight / 2, beakerWidth / 2.3, lensColor);
			beakerRect4.addChild(beakerCircle4);
			beakerCircle4.changeBorder(borderWidth*4,beakerBorder, 100);
			beakerCircle4.rotationX = 75;
			beakerCircle4.rotationZ = 1.5;
				
			beakerWaterRect4 = new PIEroundedRectangle(pieHandle, 0-beakerWidth/2, 0, beakerWidth, beakerHeight / 2, waterColor);
			beakerRect4.addChild(beakerWaterRect4);
			beakerWaterRect4.addClickListener(handleBeaker4);
			
			beakerMark4 =  new PIElabel(pieHandle, "-90ml", worldWidth / 60, backgroundActivityColor, headingTextColor);
			beakerMark4.background = false;
			beakerRect4.addChild(beakerMark4);
			beakerMark4.x = 0 + beakerWidth / 2;
			beakerMark4.y = -beakerHeight / 7.5;
		}
		
		public function setupBeaker5():void
		{
			beakerRect5 = new PIEroundedRectangle(pieHandle, beaker5TopX, beaker5TopY, beakerWidth, beakerHeight, lensColor);
			pieHandle.addDisplayChild(beakerRect5);
			beakerRect5.setPIEborder(true);
			beakerRect5.addDefaultDragAction(null, null);
			beakerRect5.changeBorderColor(beakerBorder);
			beakerRect5.changeBorderWidth(borderWidth);
			
			beakerCircle5 = new PIEcircle(pieHandle, 0, -beakerHeight / 2, beakerWidth / 2.5, lensColor);
			beakerRect5.addChild(beakerCircle5);
			beakerCircle5.changeBorder(borderWidth*3,beakerBorder, 100);
			beakerCircle5.rotationX = 75;
			beakerCircle5.rotationZ = 5;
			
			beakerWaterRect5 = new PIEroundedRectangle(pieHandle, 0-beakerWidth/2, 0, beakerWidth, beakerHeight / 2, waterColor);
			beakerRect5.addChild(beakerWaterRect5);
			beakerWaterRect5.addClickListener(handleBeaker5);
			
			beakerMark5 =  new PIElabel(pieHandle, "-90ml", worldWidth / 60, backgroundActivityColor, headingTextColor);
			beakerMark5.background = false;
			beakerRect5.addChild(beakerMark5);
			beakerMark5.x = 0 + beakerWidth / 2;
			beakerMark5.y = -beakerHeight / 7.5;
		}
		
		public function resetWorld():void
		{
			worldWidth = pieHandle.experimentDisplay.width;
			worldHeight = pieHandle.experimentDisplay.height;
			
			worldOriginX = 0;
			worldOriginY = 0;
			pieHandle.PIEsetApplicationBoundaries(worldOriginX, worldOriginY, worldWidth, worldHeight);
		}
		
		public function handleCrystal():void
		{
			clickCrystal = 1;
		}
		
		public function handleBeaker1():void
		{
			clickBeaker1 = 1;
		}
		
		public function handleBeaker2():void
		{
			clickBeaker2 = 1;
		}
		
		public function handleBeaker3():void
		{
			clickBeaker3 = 1;
		}
		
		public function handleBeaker4():void
		{
			clickBeaker4 = 1;
		}
		
		public function handleBeaker5():void
		{
			clickBeaker5 = 1;
		}
		
		public function aDrag(newX:Number, newY:Number, displacementX:Number, displacementY:Number):void
		{
			testTubeRect.x = newX ;
			testTubeRect.y = newY ;
		}
		
		public function aGrab(clickX:Number, clickY:Number):void
		{
			testTubeRect.x = clickX ;
			testTubeRect.y = clickY ;
		}
		
		public function aDrop(newX:Number, newY:Number, displacementX:Number, displacementY:Number):void
		{
			testTubeRect.x = newX ;
			testTubeRect.y = newY ;
			
			if ((testTubeRect.x < beakerRect2.x + beakerWidth/2) && (testTubeRect.x > beakerRect2.x - beakerWidth/2))
				dragTestTube2 = 1;
			else
				dragTestTube2 = 0;
			
			if ((testTubeRect.x < beakerRect3.x + beakerWidth/2) && (testTubeRect.x > beakerRect3.x - beakerWidth/2))
				dragTestTube3 = 1;
			else
				dragTestTube3 = 0;
			
			if ((testTubeRect.x < beakerRect4.x + beakerWidth/2) && (testTubeRect.x > beakerRect4.x - beakerWidth/2))
				dragTestTube4 = 1;
			else
				dragTestTube4 = 0;
				
			if ((testTubeRect.x < beakerRect5.x + beakerWidth/2) && (testTubeRect.x > beakerRect5.x - beakerWidth/2))
				dragTestTube5 = 1;
			else
				dragTestTube5 = 0;
			
			
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
			beakerColor = 0XE0EEEE;
			beakerBorder = 0X2E37FE;
			lensColor    = 0X888888;
			waterColor = 0X00FFFF;
			purpleColor1 = 0X800080;
			purpleColor2 = 0X8C198C;
			purpleColor3 = 0X993299;
			purpleColor4 = 0XB266B2;
			purpleColor5 = 0XBF7FBF;
			potassiumPermanganateColor = 0X9B30FF;
			
			pieHandle.PIEsetDisplayColors(backgroundActivityColor, displayFColor);
			pieHandle.PIEsetUIpanelColors(UIpanelBColor, UIpanelFColor);
		}
	}
}