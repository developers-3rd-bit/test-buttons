package common
{
   import com.halcyon.layout.common.HalcyonCanvas;
   
   import flash.display.DisplayObjectContainer;
   import flash.display.GradientType;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   import flashx.textLayout.formats.TextAlign;
   
   public class IconLabelVerticallyButton extends HalcyonCanvas
   {
      private static const ICON_WIDTH_HEIGHT:int = 18;
      private var _icon:Sprite;
      private var _labelField:TextField;
      private var _textFormat:TextFormat;
      
      public function IconLabelVerticallyButton(reference:DisplayObjectContainer, width:Number=60, height:Number=44)
      {
         super(reference, width, height);
         
         drawBackground([0xff0000, 0x000000]);
         
         _labelField = new TextField();
         _textFormat = new TextFormat();
         _textFormat.align = TextAlign.LEFT;
         _textFormat.color = 0xc4c4c4;
         _textFormat.bold = true;
         _labelField.setTextFormat(_textFormat);
         _labelField.mouseEnabled = false;
         _labelField.autoSize = TextFieldAutoSize.CENTER;
         
         this.prepareElementAndPosition(_labelField, height - ICON_WIDTH_HEIGHT - 2, 0, 0, 0);
         
         this.buttonMode = true;
         
         this.addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
         this.addEventListener(MouseEvent.ROLL_OUT, onMouseOut);
      }
      
      public function get label():String 
      {
         return _labelField.text;
      }
      
      public function set label(value:String):void 
      {
         _labelField.text = value;
         _labelField.setTextFormat(_textFormat);
         width = _labelField.width + 14;
         refresh();
         drawBackground([0xff0000, 0x000000]);
         icon = _icon;
      }
      
      public function set icon(value:Sprite):void
      {
         if(value == null) return;
         _icon = value;
         _icon.width = ICON_WIDTH_HEIGHT;
         _icon.height = ICON_WIDTH_HEIGHT;
         this.prepareElementAndPosition(_icon, (height - ICON_WIDTH_HEIGHT - 12) / 2, NaN, (width - ICON_WIDTH_HEIGHT) / 2, NaN);
      }
      
      private function onMouseOver(event:Event):void 
      {
         drawBackground([0xffffff, 0x7ba02b]);
         _textFormat.color = 0x000000;
         _labelField.setTextFormat(_textFormat);
      }
      
      private function onMouseOut(event:Event):void 
      {
         drawBackground([0xff0000, 0x000000]);
         _textFormat.color = 0xc4c4c4;
         _labelField.setTextFormat(_textFormat);
      }
      
      private function drawBackground(colors:Array):void
      {
         graphics.clear();
         graphics.beginGradientFill(GradientType.LINEAR, colors, [1, .8], [0, 128]);
         graphics.drawRoundRect(0, 0, width, height, 5, 5);
         graphics.endFill();
      }
   }
}