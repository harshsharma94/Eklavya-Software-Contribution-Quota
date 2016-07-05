package
{
	import flash.display.InterpolationMethod;
	import mx.skins.halo.DateChooserYearArrowSkin;
	import flash.geom.Point;
	import pie.graphicsLibrary.*;
	import pie.uiElements.*;
	
	public class Experiment
	{
		private var pieHandle:PIE;
		
		private var stopWatchTool:PIEstopWatch;
		
		private var PIEaspectRatio:Number;
		private var worldOriginX:Number;
		private var worldOriginY:Number;
		private var worldWidth:Number;
		private var worldHeight:Number;
		
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
		private var lensColor:uint;
		private var waterColor:uint;
		private var borderColor:uint;
		private var crystalColor:uint;
		private var reddishBrown:uint;
		
		private var spoonImage:PIEimage;
		private var ironNailImage:PIEimage;
		private var dilSulphuricAcidImage:PIEimage;
		
		private var heightFactor:Number;
		private var widthFactor:Number;
		private var beaker1TopX:Number;
		private var beaker1TopY:Number;
		private var beaker2TopX:Number;
		private var beaker2TopY:Number;
		private var beakerWaterRect1:PIEroundedRectangle;
		private var beakerRect1:PIEroundedRectangle;
		private var beakerCircle1:PIEcircle;
		private var beakerMark1:PIElabel;
		
		private var beakerWaterRect2:PIEroundedRectangle;
		private var beakerRect2:PIEroundedRectangle;
		private var beakerCircle2:PIEcircle;
		private var beakerMark2:PIElabel;
		
		private var beakerWidth:Number;
		private var beakerHeight:Number;
		private var borderWidth:Number;
		private var instrLabel:PIElabel;
		private var crystal:PIErectangle;
		
		private var drop1:PIEcircle;
		private var flag1:Number = 0;
		private var beakerWaterHide2:PIEroundedRectangle;
		
		//Flags
		private var timerFlag:Number = 0;
		private var clickSpoon:Number = 0;
		private var crystalsDropped:Number = 0;
		private var clickAcid:Number = 0;
		private var acidDropped:Number = 0;
		private var clickBeaker:Number = 0;
		private var solnTransferred:Number = 0;
		private var clickNail:Number = 0;
		private var x:Number = 0;
		private var rxnCompleted:Number = 0;
		
		private var spoonLabel:PIElabel;
		private var sulphuricAcidLabel:PIElabel;
		private var ironNailLabel:PIElabel;
		private var beakerALabel:PIElabel;
		private var beakerBLabel:PIElabel;
		
		private var resetButton:PIEbutton;
		
		public function Experiment(pie:PIE)
		{
			pieHandle = pie;
			
			pieHandle.PIEsetDrawingArea(1.0, 1.0);
			pieHandle.PIEsetUIpanelInvisible();
			
			this.setColor();
			
			pieHandle.showExperimentName("Chemical Change");
			pieHandle.showDeveloperName("Harsh Sharma");
			
			this.resetExperiment();
			
			widthFactor = worldWidth / 6;
			heightFactor = worldHeight / 6;
			beakerWidth = worldWidth / 10;
			beakerHeight = worldHeight / 5;
			beaker1TopX = worldWidth/10;
			beaker1TopY = 2 * worldHeight / 3 + heightFactor/2;
			beaker2TopX = 0.85 * worldWidth;
			beaker2TopY = 2 * worldHeight / 3 + heightFactor/2;
			borderWidth = worldWidth / 500;
			
			pieHandle.PIEcreateResetButton();
			pieHandle.ResetControl.visible = false;
			resetButton = new PIEbutton(pieHandle, "Reset");
			resetButton.x = pieHandle.ResetControl.x;
			resetButton.y = pieHandle.ResetControl.y - 5;
			resetButton.setActualSize(70, 22);
			resetButton.addClickListener(handleReset);
			resetButton.setVisible(true);
            pieHandle.addChild(resetButton);
			
			/*
			   pieHandle.PIEcreateResetButton();
			 pieHandle.ResetControl.addClickListener(this.resetExperiment);*/
			
			
			setupBeaker1();
			setupBeaker2();
			createExperimentObjects();
			pieHandle.PIEresumeTimer();
		}
		
		private function handleReset():void
		{
			pieHandle.PIEpauseTimer();
			if (spoonImage)
				pieHandle.experimentDisplay.removeChild(spoonImage);
			if (dilSulphuricAcidImage)
				pieHandle.experimentDisplay.removeChild(dilSulphuricAcidImage);
			if (ironNailImage)
				pieHandle.experimentDisplay.removeChild(ironNailImage);
			if (beakerRect1)
				pieHandle.experimentDisplay.removeChild(beakerRect1);
			if (beakerRect2)
				pieHandle.experimentDisplay.removeChild(beakerRect2);
			if (spoonLabel)
				pieHandle.experimentDisplay.removeChild(spoonLabel);
			if (ironNailLabel)
				pieHandle.experimentDisplay.removeChild(ironNailLabel);
			if (instrLabel)
				pieHandle.experimentDisplay.removeChild(instrLabel);
				
			timerFlag = 0;
			clickSpoon = 0;
			crystalsDropped = 0;
			clickAcid = 0;
			acidDropped = 0;
			clickBeaker = 0;
			solnTransferred = 0;
			clickNail = 0;
			x = 0;
			flag1 = 0;
			rxnCompleted = 0;
				
			setupBeaker1();
			setupBeaker2();
			createExperimentObjects();
			pieHandle.PIEresetTimer();
			pieHandle.PIEresumeTimer();
		}
		
		public function nextFrame():void
		{
			pieHandle.PIEsetDelay(35);
			if (clickSpoon == 1)
			{
				if (spoonImage.y < beaker1TopY - heightFactor)
					spoonImage.y += worldWidth / 100;
				else
				{
					spoonImage.rotationZ = 35;
					if (crystalsDropped == 0)
					{
						crystal.y = spoonImage.y + heightFactor;
						crystal.x = spoonImage.x + widthFactor/4;
						crystal.setPIEvisible();
						crystalsDropped = 1;
					}
					clickSpoon = 0;
				}
			}
			else if (crystalsDropped == 1)
			{
				if (crystal.y < beaker1TopY + beakerHeight)
				{
					crystal.y += worldWidth / 100;
				}
				else
				{
					crystal.setPIEinvisible();
					instrLabel.text = "Click the bottle of Dilute Sulphuric Acid";
					spoonImage.y = heightFactor + spoonImage.width/4;
					spoonImage.rotationZ = 0;
					crystalsDropped = 0;
				}
			}
			else if (clickAcid == 1 )
			{
				if ( dilSulphuricAcidImage.x > beaker1TopX+widthFactor/1.2)
				{
					dilSulphuricAcidImage.y += worldWidth / 100;
					dilSulphuricAcidImage.x -= worldWidth / 35;
				}
				else
				{
					clickAcid = 0;
					dilSulphuricAcidImage.rotationZ = -50;
					if (acidDropped == 0)
					{
						acidDropped = 1;
						drop1.x = dilSulphuricAcidImage.x - widthFactor/2.3;
						drop1.y = dilSulphuricAcidImage.y - heightFactor / 2;
						drop1.setPIEvisible();
					}
				}
			}
			else if (acidDropped < 5 && acidDropped != 0)
			{
				if (drop1.y < beaker1TopY + beakerHeight/1.5)
					drop1.y += worldWidth / 100;
				else
				{
					acidDropped += 1;
					drop1.x = dilSulphuricAcidImage.x - widthFactor/2.3;
					drop1.y = dilSulphuricAcidImage.y - heightFactor / 2;
					if (acidDropped == 4)
					{
						dilSulphuricAcidImage.x = worldWidth / 2;
						dilSulphuricAcidImage.y = worldHeight / 3;
						dilSulphuricAcidImage.rotationZ = 0;
						beakerWaterRect1.changeFillColor(crystalColor);
						drop1.setPIEinvisible();
						instrLabel.text = "Click Beaker A";
					}
				}
			}
			else if (clickBeaker == 1)
			{
				if (beakerRect1.x < beakerRect2.x-widthFactor/2)
				{
					beakerRect1.x += worldWidth / 100;
					beakerRect1.y -= worldHeight / 625;
				}
				else
				{
					beakerCircle1.changeBorderWidth(borderWidth/1.1);
					beakerRect1.rotationZ = 40;
					beakerCircle1.rotationZ = 10;
					beakerCircle1.rotationX = -80;
					beakerCircle1.rotationY = 15;
					if (solnTransferred == 0)
					{
						solnTransferred = 1;
					}
					clickBeaker = 0;
					beakerWaterRect2.changeFillColor(crystalColor);
				}
			}
			else if (solnTransferred < 8 && solnTransferred != 0)
			{
				pieHandle.PIEsetDelay(500);
				if (solnTransferred == 1)
					beakerWaterHide2.height *= 2;
				beakerWaterHide2.height -= (0.05 * beakerWaterHide2.height);
				beakerWaterRect1.y += (beakerWaterRect1.height * solnTransferred/150);
				beakerWaterRect1.height -= (0.05 * beakerWaterRect1.height);
				beakerWaterHide2.y = 0;
				solnTransferred += 1;
			}
			else if (solnTransferred == 8)
			{
				beakerRect1.rotationZ = 0;
				beakerCircle1.rotationX = 70;
				beakerCircle1.rotationY = 0;
				beakerCircle1.rotationZ = 0;
				beakerRect1.x = beaker1TopX + beakerWidth/2;
				beakerRect1.y = beaker1TopY + beakerHeight / 2;
				solnTransferred = 0;
				instrLabel.text = "Click Iron Nail";
			}
			else if (clickNail == 1)
			{
				if (ironNailImage.y < beaker2TopY - heightFactor/1.8)
				{
					ironNailImage.y += worldWidth / 100;
				}
				else
				{
					ironNailImage.rotationZ = -60;
					if (ironNailImage.y < beaker2TopY + heightFactor/1.5)
						ironNailImage.y += worldWidth / 100;
					else if(timerFlag==0)
					{
						//instrLabel.visible = false;
						//stopWatchTool.setPIEvisible();
						pieHandle.PIEsetTime(0.0);
						timerFlag = 1;
						instrLabel.text = "0";
						instrLabel.x = worldWidth / 2.3;
					}
					else
					{
						pieHandle.PIEsetDelay(300);
						x = (parseInt(instrLabel.text) + 1);
						if (x<21)
							instrLabel.text = x.toString() + " minutes";
						else
						{
							instrLabel.x = worldWidth / 2.5;
							instrLabel.text = "Reaction Completed";
							beakerWaterRect2.changeFillColor(greenColor);
							clickNail = 0;
							rxnCompleted = 1;
						}
						//stopWatchTool.changeTime(pieHandle.PIEgetTime());
					}
				}
			}
			else if (rxnCompleted == 1)
			{
				pieHandle.experimentDisplay.removeChild(ironNailImage);
				ironNailImage = new PIEimage(pieHandle, beaker2TopX+widthFactor/12, beaker2TopY-3*heightFactor, 3*0.3*widthFactor, 3*0.5*heightFactor, PIEimageLocation.ironNailImgPtr);
				ironNailImage.setPIEborder(false);
				pieHandle.addDisplayChild(ironNailImage);
				//ironNailImage.rotationZ = 0;
				ironNailImage.x = worldWidth/2;
				ironNailImage.y = worldHeight-heightFactor/2;
				//ironNailImage.width *= 3;
				//ironNailImage.height *= 3;
				var circle:Vector.<PIEcircle> = new Vector.<PIEcircle>(5);
				circle[0] = new PIEcircle(pieHandle, 0, 0, worldWidth / 250, reddishBrown);
				circle[1] = new PIEcircle(pieHandle, -ironNailImage.width/5, ironNailImage.height/5, worldWidth / 250, reddishBrown);
				circle[2] = new PIEcircle(pieHandle, -ironNailImage.width/4, ironNailImage.height/4, worldWidth / 250, reddishBrown);
				circle[3] = new PIEcircle(pieHandle, -ironNailImage.width/6, ironNailImage.height/6, worldWidth / 250, reddishBrown);
				circle[4] = new PIEcircle(pieHandle, -ironNailImage.width/8, ironNailImage.height/8, worldWidth / 250, reddishBrown);
				var i:Number;
				for (i = 0; i < 5; i++)
				{
					ironNailImage.addChild(circle[i]);
				}
				dilSulphuricAcidImage.setPIEinvisible();
				spoonImage.setPIEinvisible();
				pieHandle.experimentDisplay.removeChild(instrLabel);
				instrLabel = new PIElabel(pieHandle, "The activity shows the Displacement reaction of Copper Sulphate with Iron.\n" +
									"\t\t\t\t\t\t\tCuS04 + Fe -->  FeS04 + Cu\n" +
									" Copper deposits on the Iron nail in the form of Reddish Brown coating.", worldWidth / 37, backgroundActivityColor, headingTextColor);
				pieHandle.addDisplayChild(instrLabel);
				//instrLabel.background = false;
				instrLabel.x = widthFactor/3;
				instrLabel.y = worldHeight / 3;
				instrLabel.backgroundColor = greenColor;
				rxnCompleted = 0;
				spoonLabel.visible = false;
				ironNailLabel.visible = false;
			}
			
		}
		
		public function setupBeaker1():void 
		{
			beakerRect1 = new PIEroundedRectangle(pieHandle, beaker1TopX, beaker1TopY, beakerWidth, beakerHeight, lensColor);
			pieHandle.addDisplayChild(beakerRect1);
			beakerRect1.setPIEborder(true);
			//beakerRect1.addDefaultDragAction(null, null);
			beakerRect1.changeBorderColor(borderColor);
			beakerRect1.changeBorderWidth(borderWidth);
			
			//beakerCircle1 = new PIEcircle(pieHandle, beakerRect1.x , beakerRect1.y - beakerRect1.height / 2 , beakerRect1.width / 2, lensColor);
			beakerCircle1 = new PIEcircle(pieHandle, 0, -beakerHeight / 2, beakerWidth / 2, lensColor);
			beakerRect1.addChild(beakerCircle1);
			beakerCircle1.changeBorder(borderWidth * 4, borderColor, 100);
			beakerCircle1.rotationX = 75;
					
			beakerWaterRect1 = new PIEroundedRectangle(pieHandle, 0-beakerWidth/2, 0, beakerWidth, beakerHeight / 2, waterColor);
			beakerRect1.addChild(beakerWaterRect1);
			beakerWaterRect1.addClickListener(handleBeaker1);
			
			beakerMark1 =  new PIElabel(pieHandle, "-100ml", worldWidth / 60, backgroundActivityColor, headingTextColor);
			beakerMark1.background = false;
			beakerRect1.addChild(beakerMark1);
			beakerMark1.x = 0 + beakerWidth / 2;
			beakerMark1.y = -beakerHeight / 7.5;
		}
		
		public function handleBeaker1():void 
		{
			clickBeaker = 1;
		}
		
		public function setupBeaker2():void
		{
			
			beakerRect2 = new PIEroundedRectangle(pieHandle, beaker2TopX, beaker2TopY, beakerWidth, beakerHeight, lensColor);
			pieHandle.addDisplayChild(beakerRect2);
			beakerRect2.setPIEborder(true);
			beakerRect2.changeBorderColor(borderColor);
			beakerRect2.changeBorderWidth(borderWidth);

			beakerCircle2 = new PIEcircle(pieHandle, 0, -beakerHeight / 2, beakerWidth / 2.7, lensColor);
			beakerRect2.addChild(beakerCircle2);
			beakerCircle2.changeBorder(borderWidth*3,borderColor, 100);
			beakerCircle2.rotationX = 75;
			beakerCircle2.rotationZ = 5;
			
			beakerWaterRect2 = new PIEroundedRectangle(pieHandle, 0-beakerWidth/2, 0, beakerWidth, beakerHeight / 2, waterColor);
			beakerRect2.addChild(beakerWaterRect2);
			
			beakerWaterHide2 = new PIEroundedRectangle(pieHandle, 0 - beakerWidth / 2, 0, beakerWidth, beakerHeight / 2, lensColor);
			beakerRect2.addChild(beakerWaterHide2);
			
			beakerMark2 =  new PIElabel(pieHandle, "-100ml", worldWidth / 60, backgroundActivityColor, headingTextColor);
			beakerMark2.background = false;
			beakerRect2.addChild(beakerMark2);
			beakerMark2.x = 0 + beakerWidth / 2;
			beakerMark2.y = -beakerHeight / 7.5;
		}
		
		public function resetExperiment():void
		{
			this.resetWorld();
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
		
		private function createExperimentObjects():void
		{
			spoonImage = new PIEimage(pieHandle, widthFactor/3, heightFactor, worldWidth / 6, worldHeight / 6, PIEimageLocation.spoonImgPtr);
			pieHandle.addDisplayChild(spoonImage);
			spoonImage.addClickListener(handleSpoon);
			spoonImage.setPIEborder(false);
			
			dilSulphuricAcidImage = new PIEimage(pieHandle, 2.8*widthFactor, heightFactor,3*widthFactor,2*heightFactor, PIEimageLocation.dilSulphuricAcidImgPtr);
			pieHandle.addDisplayChild(dilSulphuricAcidImage);
			dilSulphuricAcidImage.addClickListener(handleAcid);
			dilSulphuricAcidImage.setPIEborder(false);
			
			ironNailImage = new PIEimage(pieHandle, beaker2TopX+widthFactor/12, beaker2TopY-3*heightFactor, 0.6*widthFactor, 0.8*heightFactor, PIEimageLocation.ironNailImgPtr);
			ironNailImage.setPIEborder(false);
			pieHandle.addDisplayChild(ironNailImage);
			ironNailImage.addClickListener(handleNail);
			
			crystal = new PIErectangle(pieHandle, 1.25 * worldWidth / 10, spoonImage.y, worldWidth / 100, 2*worldHeight / 100, crystalColor);
			pieHandle.addChild(crystal);
			crystal.setPIEinvisible();
			
			drop1 = new PIEcircle(pieHandle, 0, 0,
						widthFactor / 60, waterColor);
			pieHandle.addDisplayChild(drop1);
			drop1.setPIEinvisible();
			
			instrLabel = new PIElabel(pieHandle, "Click the spoon with Copper Sulphate Crystals", worldWidth / 23, backgroundActivityColor, headingTextColor);
			instrLabel.background = false;
			instrLabel.setLabelUnderline(true);
			instrLabel.text = "Click the spoon with Copper Sulphate Crystals";
			pieHandle.addDisplayChild(instrLabel);
			instrLabel.x = worldWidth / 24;
			
			stopWatchTool = new PIEstopWatch(pieHandle, 10, 10, 100, 60);
			pieHandle.addDisplayChild(stopWatchTool);
			stopWatchTool.setPIEinvisible();
			
			spoonLabel = new PIElabel(pieHandle, "Spoon", worldWidth / 30, backgroundActivityColor, headingTextColor);
			pieHandle.addDisplayChild(spoonLabel);
			spoonLabel.y = spoonImage.y - spoonImage.width / 2;
			spoonLabel.x = spoonImage.x ;
			
			ironNailLabel = new PIElabel(pieHandle, "Iron Nail", worldWidth / 30, backgroundActivityColor, headingTextColor);
			pieHandle.addDisplayChild(ironNailLabel);
			ironNailLabel.y = ironNailImage.y - heightFactor / 1.5;
			ironNailLabel.x = ironNailImage.x - ironNailImage.width;
			
			beakerALabel =  new PIElabel(pieHandle, "Beaker A", worldWidth / 30, backgroundActivityColor, headingTextColor);
			pieHandle.addDisplayChild(beakerALabel);
			beakerALabel.x = beakerRect1.x + beakerRect1.height/2;
			beakerALabel.y = beakerRect1.y + beakerRect1.width / 3.5;
			
			beakerBLabel =  new PIElabel(pieHandle, "Beaker B", worldWidth / 30, backgroundActivityColor, headingTextColor);
			pieHandle.addDisplayChild(beakerBLabel);
			beakerBLabel.x = beakerRect2.x - beakerRect2.height/0.7;
			beakerBLabel.y = beakerRect2.y + beakerRect2.width / 3.5;
			
		}
		
		private function handleNail():void 
		{
			clickNail = 1;
		}
		
		private function handleAcid():void 
		{
			clickAcid = 1;
		}
		
		private function handleSpoon():void 
		{
			clickSpoon = 1;
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
			lensColor    = 0X888888;
			waterColor = 0X00FFFF;
			borderColor = 0X2E37FE;
			crystalColor = 0X264EF8;
			reddishBrown = 0XB85750;
			
			pieHandle.PIEsetDisplayColors(backgroundActivityColor, displayFColor);
			pieHandle.PIEsetUIpanelColors(UIpanelBColor, UIpanelFColor);
		}
	
	}

}
