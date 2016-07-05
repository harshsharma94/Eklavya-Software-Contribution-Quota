package  
{

public class TrueFalseProblems 
{
/* TestProject Framework Handle */
private var experimentName:String;                /* Title which appears on top border */
private var developerName:String;                 /* Developer name which appears on top border */

/* Experiment Question Bank and Choice */
private var questionBank:Vector.<String>;         /* Question Bank */

public function TrueFalseProblems() 
{
    /* Initialise Question Bank */
    this.initialiseQuestionBank();
}

/**
 *
 * This function fills the array of True/false problem statements
 * This function also creates all the required vectors
 * Each question is a string
 * The first character of each quaestion string is a digit
 * The true statement has digit 1 while the false statement has digit 0
 * 
 * Important : The problem statements are picked up at random. Therefore statements can be repeated to ensure greater frequency.
 *
 */
public function initialiseQuestionBank():void
{
    /* Set Title and Developer */
    experimentName = new String("Separation and Sorting of Substances-True and False activity");
    developerName  = new String("Harsh Sharma");

    /* Now create the problem sentence array */
    questionBank = new Vector.<String>();

    /* The problem statements are hardcoded here */
	questionBank.push("0Stones are separated from grains by threshing");
	questionBank.push("0Large number of impurities can be separated by hand-picking");
	questionBank.push("1The process that is used to separate grain from stalks etc. is called threshing.");
	questionBank.push("1Machines and bullocks are used to thresh grains.");
	questionBank.push("0Winnowing separates the heavier and lighter components of a mixture by running water.");
	questionBank.push("0Threshing and winnowing completely remove the impurities present in wheat.");
	questionBank.push("0A mixture of oil and water can't be separated by sedimentation and decantation.");
	questionBank.push("0A mixture of powdered salt and sugar can be separated by the process of winnowing.");
	questionBank.push("1Sieving is used when components of a mixture have different sizes.");
	questionBank.push("0When the heavier component in a mixture settles after water is added to it, the process is called decantation.");
	questionBank.push("0When the water (along with the dust) is removed after settling, the process is called sedimentation.");
	questionBank.push("0Separation of milk from coffee can be done with filtration.");
	questionBank.push("1Oil and water can be separated by sedimentation and decantation.");
	questionBank.push("0Miscible liquids can be separated by sedimentation and decantation.");
	questionBank.push("1A mixture of two immiscible liquids form two separate layers on sedimentation.");
	questionBank.push("0A mixture of milk and water can be separated by filtration.");
	questionBank.push("0If a mixture of two immiscible liquids is allowed to stand for some time, they still form a single layer.");
	questionBank.push("0Decantation completely removes the tea leaves present after preparing tea.");
	questionBank.push("0A strainer can be used for filtration, while a piece of cloth cannot be used for the same.");
	questionBank.push("1Small pores/holes in between woven threads in a cloth can be used as a filter.");
	questionBank.push("0A filter paper has very coarse pores in it.");
	questionBank.push("1Filter paper is folded in a cone shape to allow liquid mixture to pass through it.");
	questionBank.push("0Cottage cheese is prepared by the process of Winnowing.");
	questionBank.push("0The process of conversion of water into its vapour is called condensation.");
	questionBank.push("0Evaporation is a discontinuous process.");
	questionBank.push("1Sea water when allowed to stand in shallow pits heated by sunlight, leaves water behind.");
	questionBank.push("0The process of conversion of water vapour into its liquid form is called evaporation.");
	questionBank.push("0When the steam comes in contact with metal plate cooled with ice, it evaporates.");
	questionBank.push("0All substances dissolve in water to form a solution.");
	questionBank.push("0Infinite amount of salt can be dissolved in a particular volume of water.");
	questionBank.push("1When a hot saturated salt solution is heated with salt, undissolved salt appears on cooling.");
	questionBank.push("0Water dissolves equal amounts of different soluble substances.");
	questionBank.push("1More of a substance can be dissolved in a solution by heating it.");
	questionBank.push("0Grain and husk can be separated with the process of filtration.");
	questionBank.push("0Seperation of substances always  results in a single useful component.");
	questionBank.push("1Sugar can be separated from wheat flour by sieving.");
	questionBank.push("0Sugar dissolve in cold water faster than in hot water.");
	questionBank.push("1The process of solid changing directly in vapour form without becoming liquid is called sublimation.");
	questionBank.push("1The solubility of water increases with an increase in amount of water.");
	questionBank.push("1Washing machine operates on the principle of centrifugation.");
	questionBank.push("1Evaporation can be used to separate solids dissolved in a liquid.");
	questionBank.push("0Two groups of objects cannot have identical materials.");
	questionBank.push("0Materials through which things can be seen, but partially are called opaque.");
	questionBank.push("0Every object is made up of only a single material.");
	questionBank.push("1One material can be used for making different objects.");
	questionBank.push("0A tumbler can be made with a piece of cloth for holding water.");
	questionBank.push("0Grouping of materials and objects causes inconvenience in their study.");
	questionBank.push("1Vinegar is soluble in water.");
	questionBank.push("1A material is chosen to make an object depending on its properties and purpose of object use.");
	questionBank.push("1Sand paper can be rubbed with a material to see if it has lustre.");
	questionBank.push("1A log of wood floats on the surface of water.");
	questionBank.push("0Action of air and water on a metal makes it shiny.");
	questionBank.push("0All materials can be easily compressed.");
	questionBank.push("0Hard materials are those which can be compressed and scratched easily.");
	questionBank.push("0Malleability of water plays an important role in functioning of body by dissolving substances.");
	questionBank.push("0All gases dissolve in water.");
	questionBank.push("0Substances or materials through which things can be seen are called translucent.");
	questionBank.push("0Oiled paper is an example of transparent object.");
	questionBank.push("1Palm of your hand is translucent.");
	questionBank.push("0Materials can only be grouped on the basis of their similarities in properties.");
	questionBank.push("1Wood is opaque, while glass is transparent.");
	questionBank.push("0Chalk possesses the property of lustre.");
	questionBank.push("1Oil and water form an immiscible mixture of liquids.");
	questionBank.push("0Salt does not dissolve in water.");
	questionBank.push("1Generally, substances having less density than oil and water can float on them.");
	questionBank.push("0Solid substances have fixed volume, but no fixed shape.");
	questionBank.push("1Rate of sedimentation is increased by adding Alum to the water.");
	questionBank.push("1The process of increasing the rate of sedimentation in a suspension by adding some chemical is called Loading.");
	questionBank.push("1Butter is separated from curd by the process of Churning.");
	questionBank.push("0A solution which cannot dissolve more of a given substance at a given temperature is called Unsaturated Solution.");
	questionBank.push("0A pure solid can be obtained from its solution by the process of Sedimentation.");
	questionBank.push("0Seperation of kerosene oil and water is done by Crystallisation.");
	questionBank.push("0The clear liquid obtained after filtration is called Residue.");
	questionBank.push("1To evaporate a liquid into its vapours, heat the liquid below its boiling point.");
	questionBank.push("1A saturated solution can dissolve more of a substance on heating.");
	questionBank.push("1Cotton fibre is separated from cotton seeds by the process of Ginning");
	questionBank.push("1The liquid above the sediment is called supernatant liquid.");
	questionBank.push("0Chalk cannot be separated from water by the process of filtration.");
	questionBank.push("1Sand and iron fillings are separated by the process of Magnetic Separation.");
	questionBank.push("0Property of metals to be drawn into thin wire is called Malleability.");
	questionBank.push("0All objects that are round in shape, are also edible.");
}

/**
 *
 * This function returns question given index
 *
 */
public function getQuestion(qIndex:uint):String
{
    if (qIndex < questionBank.length) { return(questionBank[qIndex]); }
    else  { return(new String("0")); }
}

/**
 *
 * This function returns question bank size
 *
 */
public function getQuestionBankSize():uint
{
    return(questionBank.length);
}

/**
 *
 * This function returns experiment name
 *
 */
public function getExperimentName():String
{
    return(experimentName);
}

/**
 *
 * This function returns developer name
 *
 */
public function getDeveloperName():String
{
    return(developerName);
}

}

}
