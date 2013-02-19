package
{
   import com.halcyon.layout.common.HalcyonVGroup;
   import com.halcyon.layout.common.Utils;
   
   import common.IconLabelHorizontallyButton;
   import common.IconLabelVerticallyButton;
   import common.LabelOnlyButton;
   
   import fl.controls.ComboBox;
   
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public class Main extends Sprite
   {
      private var _vGroup:HalcyonVGroup;
      private var _localeDropDown:ComboBox;
      private var _labelOnlyButton:LabelOnlyButton;
      private var _iconLabelHorizontallyButton:IconLabelHorizontallyButton;
      private var _iconLabelVerticallyButton:IconLabelVerticallyButton;
      
      public function Main()
      {
         Utils.locales.push({label:"German", value:"de_DE"});
         
         _vGroup = new HalcyonVGroup(this);
         _vGroup.verticalGap = 20;
         
         _localeDropDown = new ComboBox();
         _localeDropDown.dataProvider.addItems(Utils.locales);
         _localeDropDown.addEventListener(Event.CHANGE, onLocaleChange, false, 0, true);
         _vGroup.addChild(_localeDropDown);
         
         _labelOnlyButton = new LabelOnlyButton(this);
         _labelOnlyButton.addEventListener(MouseEvent.CLICK, onButtonClick, false, 0, true);
         _vGroup.addChild(_labelOnlyButton);
         
         _iconLabelHorizontallyButton = new IconLabelHorizontallyButton(this);
         _iconLabelHorizontallyButton.icon = new McCallIcon();
         _iconLabelHorizontallyButton.addEventListener(MouseEvent.CLICK, onButtonClick, false, 0, true);
         _vGroup.addChild(_iconLabelHorizontallyButton);
         
         _iconLabelVerticallyButton = new IconLabelVerticallyButton(this);
         _iconLabelVerticallyButton.icon = new McComputerMicIcon();
         _iconLabelVerticallyButton.addEventListener(MouseEvent.CLICK, onButtonClick, false, 0, true);
         _vGroup.addChild(_iconLabelVerticallyButton);
         
         this.addChild(_vGroup);
         
         loadLocale("en_US");
      }
      
      private function onLocaleChange(event:Event):void 
      {
         loadLocale(event.currentTarget.selectedItem.value);
      }
      
      private function loadLocale(value:String):void 
      {
         var loader:URLLoader = new URLLoader(new URLRequest("\assets/locale/"+ value +"/resources.xml"));
         loader.addEventListener(Event.COMPLETE, xmlLoaded);
      }
      
      private function xmlLoaded(e:Event):void 
      {
         Utils.resourcesXml = new XML(e.target.data);
         e.currentTarget.removeEventListener(Event.COMPLETE, xmlLoaded);
         updateLabel();
      }
      
      private function updateLabel():void
      {
         _labelOnlyButton.label = Utils.resourcesXml.labelOnlyButton.label;
         _iconLabelHorizontallyButton.label = Utils.resourcesXml.iconLabelHorizontallyButton.label;
         _iconLabelVerticallyButton.label = Utils.resourcesXml.iconLabelVerticallyButton.label;
      }
      
      private function onButtonClick(event:Event):void
      {
         if(event.currentTarget == _labelOnlyButton)
            trace("Received click event from _labelOnlyButton");
         else if(event.currentTarget == _iconLabelHorizontallyButton)
            trace("Received click event from _iconLabelHorizontallyButton");
         else if(event.currentTarget == _iconLabelVerticallyButton)
            trace("Received click event from _iconLabelVerticallyButton");
      }
   }
}