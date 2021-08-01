package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;
	var portraitKaz:FlxSprite;
	var portraitSpiritKaz:FlxSprite;
	var portraitMom:FlxSprite;
	var portraitPico:FlxSprite;
	var portraitSkid:FlxSprite;
	var portraitGf:FlxSprite;
	var spookyDance:FlxSprite;
	


	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		box = new FlxSprite(-20, 425);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'thinkso' | 'popyskweak' | 'bringiton' | 'bringittoanend' :
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;

		
		portraitLeft = new FlxSprite(750, 100);
		portraitLeft.frames = Paths.getSparrowAtlas('characters/other_dialogue');
		portraitLeft.animation.addByPrefix('enter', 'Other0000', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.00001));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;
		
		portraitKaz = new FlxSprite(150, 100);
		portraitKaz.frames = Paths.getSparrowAtlas('characters/kazUualdialogue');
		portraitKaz.animation.addByPrefix('enter', 'Symbole 10000', 24, false);
		portraitKaz.setGraphicSize(Std.int(portraitKaz.width * PlayState.daPixelZoom * 0.00001));
		portraitKaz.updateHitbox();
		portraitKaz.scrollFactor.set();
		add(portraitKaz);
		portraitKaz.visible = false;

		portraitSpiritKaz = new FlxSprite(150, 100);
		portraitSpiritKaz.frames = Paths.getSparrowAtlas('characters/kazUualdialogue');
		portraitSpiritKaz.animation.addByPrefix('enter', 'Symbole 10001', 24, false);
		portraitSpiritKaz.setGraphicSize(Std.int(portraitSpiritKaz.width * PlayState.daPixelZoom * 0.00001));
		portraitSpiritKaz.updateHitbox();
		portraitSpiritKaz.scrollFactor.set();
		add(portraitSpiritKaz);
		portraitSpiritKaz.visible = false;

		portraitRight = new FlxSprite(750, 250);
		portraitRight.frames = Paths.getSparrowAtlas('bf_norm');
		portraitRight.animation.addByPrefix('enter', 'BF Portrait Enter instance 10000', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.0001));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;

		portraitMom = new FlxSprite(700, 100);
		portraitMom.frames = Paths.getSparrowAtlas('characters/other_dialogue');
		portraitMom.animation.addByPrefix('enter', 'Other0001', 24, false);
		portraitMom.setGraphicSize(Std.int(portraitMom.width * PlayState.daPixelZoom * 0.00001));
		portraitMom.updateHitbox();
		portraitMom.scrollFactor.set();
		add(portraitMom);
		portraitMom.visible = false;

		portraitPico = new FlxSprite(650, 250);
		portraitPico.frames = Paths.getSparrowAtlas('characters/other_dialogue');
		portraitPico.animation.addByPrefix('enter', 'Other0002', 24, false);
		portraitPico.setGraphicSize(Std.int(portraitPico.width * PlayState.daPixelZoom / 9));
		portraitPico.updateHitbox();
		portraitPico.scrollFactor.set();
		add(portraitPico);
		portraitPico.visible = false;

		portraitSkid = new FlxSprite(680, 70);
		portraitSkid.frames = Paths.getSparrowAtlas('characters/other_dialogue');
		portraitSkid.animation.addByPrefix('enter', 'Other0003', 24, false);
		portraitSkid.setGraphicSize(Std.int(portraitSkid.width * PlayState.daPixelZoom * 0.00001));
		portraitSkid.updateHitbox();
		portraitSkid.scrollFactor.set();
		add(portraitSkid);
		portraitSkid.visible = false;

		spookyDance = new FlxSprite(650, 0);
		spookyDance.frames = Paths.getSparrowAtlas('characters/spooky_kids_assets');
		spookyDance.animation.addByPrefix('enter', 'spooky dance', 24);
		spookyDance.setGraphicSize(Std.int(spookyDance.width * PlayState.daPixelZoom * 0.00000001));
		spookyDance.updateHitbox();
		spookyDance.scrollFactor.set();
		add(spookyDance);
		spookyDance.visible = false;

		portraitGf = new FlxSprite(700, 240);
		portraitGf.frames = Paths.getSparrowAtlas('characters/GF');
		portraitGf.animation.addByPrefix('enter', 'GF', 24, false);
		portraitGf.setGraphicSize(Std.int(portraitGf.width * PlayState.daPixelZoom * 0.00001));
		portraitGf.updateHitbox();
		portraitGf.scrollFactor.set();
		add(portraitGf);
		portraitGf.visible = false;

		box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.15));
		box.updateHitbox();
		add(box);

		box.screenCenter(X);

		handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('pixelUI/hand_textbox'));
		add(handSelect);


		if (!talkingRight)
		{
			// box.flipX = true;
		}

		dropText = new FlxText(242, 512, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = 'Pixel Arial 11 Bold';
		dropText.color = 0xFFD89494;
		add(dropText);

		swagDialogue = new FlxTypeText(240, 510, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.font = 'Pixel Arial 11 Bold';
		swagDialogue.color = 0xFF3F2021;
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (FlxG.keys.justPressed.ANY  && dialogueStarted == true)
		{
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						portraitRight.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		switch (curCharacter)
		{

			case 'dad':
				portraitRight.visible = false;
				portraitKaz.visible = false;
				portraitMom.visible = false;
				portraitPico.visible = false;
				portraitSkid.visible = false;
				spookyDance.visible = false;
				portraitGf.visible = false;
				portraitSpiritKaz.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
			case 'bf':
				portraitLeft.visible = false;
				portraitKaz.visible = false;
				portraitMom.visible = false;
				portraitPico.visible = false;
				portraitSkid.visible = false;
				spookyDance.visible = false;
				portraitGf.visible = false;
				portraitSpiritKaz.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
				}
			case 'kaz':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitMom.visible = false;
				portraitPico.visible = false;
				portraitSkid.visible = false;
				spookyDance.visible = false;
				portraitGf.visible = false;
				portraitSpiritKaz.visible = false;
				if (!portraitKaz.visible)
				{
					portraitKaz.visible = true;
					portraitKaz.animation.play('enter');
				}
			case 'spiritkaz':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitMom.visible = false;
				portraitPico.visible = false;
				portraitSkid.visible = false;
				spookyDance.visible = false;
				portraitGf.visible = false;
				if (!portraitSpiritKaz.visible)
				{
					portraitSpiritKaz.visible = true;
					portraitSpiritKaz.animation.play('enter');
				}
				
			case 'mom':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitKaz.visible = false;
				portraitPico.visible = false;
				portraitSkid.visible = false;
				spookyDance.visible = false;
				portraitGf.visible = false;
				portraitSpiritKaz.visible = false;
				if (!portraitMom.visible)
				{
					portraitMom.visible = true;
					portraitMom.animation.play('enter');
				}
			case 'pico':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitKaz.visible = false;
				portraitSkid.visible = false;
				portraitMom.visible = false;
				spookyDance.visible = false;
				portraitGf.visible = false;
				portraitSpiritKaz.visible = false;
				if (!portraitPico.visible)
				{
					portraitPico.visible = true;
					portraitPico.animation.play('enter');
				}
			case 'skid':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitKaz.visible = false;
				portraitPico.visible = false;
				portraitMom.visible = false;
				spookyDance.visible = false;
				portraitGf.visible = false;
				portraitSpiritKaz.visible = false;
				if (!portraitSkid.visible)
				{
					portraitSkid.visible = true;
					portraitSkid.animation.play('enter');
				}
			case 'skidetpumpspookydance':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitKaz.visible = false;
				portraitPico.visible = false;
				portraitMom.visible = false;
				portraitSkid.visible = false;
				portraitGf.visible = false;
				portraitSpiritKaz.visible = false;
				if (!spookyDance.visible)
				{
					spookyDance.visible = true;
					spookyDance.animation.play('enter');
				}
			case 'gf':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitKaz.visible = false;
				portraitPico.visible = false;
				portraitMom.visible = false;
				portraitSkid.visible = false;
				portraitSpiritKaz.visible = false;
				spookyDance.visible = false;
				if (!portraitGf.visible)
				{
					portraitGf.visible = true;
					portraitGf.animation.play('enter');
				}

		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}
