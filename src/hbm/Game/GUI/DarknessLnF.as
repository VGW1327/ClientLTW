


//hbm.Game.GUI.DarknessLnF

package hbm.Game.GUI
{
    import org.aswing.plaf.basic.BasicLookAndFeel;
    import org.aswing.UIDefaults;
    import org.aswing.plaf.basic.BasicButtonUI;
    import org.aswing.plaf.basic.BasicPanelUI;
    import org.aswing.plaf.basic.BasicToggleButtonUI;
    import org.aswing.plaf.basic.BasicRadioButtonUI;
    import org.aswing.plaf.basic.BasicCheckBoxUI;
    import org.aswing.plaf.basic.BasicColorSwatchesUI;
    import org.aswing.plaf.basic.BasicColorMixerUI;
    import org.aswing.plaf.basic.BasicColorChooserUI;
    import org.aswing.plaf.basic.BasicScrollBarUI;
    import org.aswing.plaf.basic.BasicSeparatorUI;
    import org.aswing.plaf.basic.BasicViewportUI;
    import org.aswing.plaf.basic.BasicScrollPaneUI;
    import org.aswing.plaf.basic.BasicLabelUI;
    import org.aswing.plaf.basic.BasicTextFieldUI;
    import org.aswing.plaf.basic.BasicTextAreaUI;
    import org.aswing.plaf.basic.BasicFrameUI;
    import org.aswing.plaf.basic.BasicToolTipUI;
    import org.aswing.plaf.basic.BasicProgressBarUI;
    import org.aswing.plaf.basic.BasicListUI;
    import org.aswing.plaf.basic.BasicComboBoxUI;
    import org.aswing.plaf.basic.BasicSliderUI;
    import org.aswing.plaf.basic.BasicAdjusterUI;
    import org.aswing.plaf.basic.BasicAccordionUI;
    import org.aswing.plaf.basic.BasicTabbedPaneUI;
    import org.aswing.plaf.basic.BasicSplitPaneUI;
    import org.aswing.plaf.basic.BasicSpacerUI;
    import org.aswing.plaf.basic.BasicTableUI;
    import org.aswing.plaf.basic.BasicTableHeaderUI;
    import org.aswing.plaf.basic.BasicTreeUI;
    import org.aswing.plaf.basic.BasicStepperUI;
    import org.aswing.plaf.basic.BasicToolBarUI;
    import org.aswing.plaf.ASColorUIResource;
    import org.aswing.plaf.ASFontUIResource;
    import org.aswing.resizer.ResizerController;
    import org.aswing.resizer.DefaultResizer;
    import org.aswing.plaf.basic.cursor.H_ResizeCursor;
    import org.aswing.plaf.basic.cursor.V_ResizeCursor;
    import org.aswing.plaf.basic.cursor.HV_ResizeCursor;
    import org.aswing.ASFont;
    import org.aswing.plaf.UIStyleTune;
    import org.aswing.plaf.basic.background.ButtonBackground;
    import org.aswing.plaf.InsetsUIResource;
    import org.aswing.plaf.ArrayUIResource;
    import flash.filters.DropShadowFilter;
    import org.aswing.plaf.basic.background.PanelBackground;
    import org.aswing.plaf.basic.background.ToggleButtonBackground;
    import org.aswing.plaf.basic.icon.RadioButtonIcon;
    import org.aswing.plaf.basic.icon.CheckBoxIcon;
    import org.aswing.plaf.basic.background.ScrollBarBackground;
    import org.aswing.plaf.basic.background.ScrollBarThumb;
    import org.aswing.plaf.basic.background.ProgressBarBackground;
    import org.aswing.plaf.basic.background.ProgressBarIcon;
    import org.aswing.plaf.basic.background.TextComponentBackBround;
    import org.aswing.plaf.basic.border.EmptyBorderResource;
    import org.aswing.Insets;
    import org.aswing.plaf.basic.background.FrameBackground;
    import org.aswing.plaf.basic.icon.TitleIcon;
    import org.aswing.plaf.basic.icon.FrameIconifiedIcon;
    import org.aswing.plaf.basic.icon.FrameNormalIcon;
    import org.aswing.plaf.basic.icon.FrameMaximizeIcon;
    import org.aswing.plaf.basic.icon.FrameCloseIcon;
    import org.aswing.plaf.basic.background.ToolTipBackground;
    import org.aswing.plaf.basic.background.ListBackground;
    import org.aswing.plaf.basic.border.ComboBoxPopupBorder;
    import org.aswing.plaf.basic.background.InputBackground;
    import org.aswing.plaf.basic.icon.SliderThumbIcon;
    import org.aswing.plaf.basic.adjuster.PopupSliderThumbIcon;
    import org.aswing.plaf.basic.border.ColorChooserBorder;
    import org.aswing.plaf.basic.background.TableBackground;
    import org.aswing.plaf.basic.background.TableHeaderBackground;
    import org.aswing.plaf.basic.border.TableHeaderCellBorder;
    import org.aswing.tree.TreeLeafIcon;
    import org.aswing.tree.TreeFolderIcon;
    import org.aswing.plaf.basic.tree.BasicExpandControl;
    import org.aswing.plaf.basic.icon.MenuItemArrowIcon;
    import org.aswing.plaf.basic.icon.MenuItemCheckIcon;
    import org.aswing.plaf.basic.icon.CheckBoxMenuItemCheckIcon;
    import org.aswing.plaf.basic.icon.RadioButtonMenuItemCheckIcon;
    import org.aswing.plaf.basic.icon.MenuArrowIcon;
    import org.aswing.plaf.basic.icon.MenuCheckIcon;
    import org.aswing.plaf.basic.border.PopupMenuBorder;
    import org.aswing.plaf.*;
    import org.aswing.resizer.*;
    import org.aswing.tree.*;
    import org.aswing.plaf.basic.*;
    import org.aswing.plaf.basic.cursor.*;
    import org.aswing.plaf.basic.icon.*;
    import org.aswing.plaf.basic.background.*;
    import org.aswing.plaf.basic.border.*;

    public class DarknessLnF extends BasicLookAndFeel 
    {


        override public function getDefaults():UIDefaults
        {
            var _local_1:UIDefaults = new UIDefaults();
            this.initClassDefaults(_local_1);
            this.initSystemColorDefaults(_local_1);
            this.initSystemFontDefaults(_local_1);
            this.initCommonUtils(_local_1);
            this.initComponentDefaults(_local_1);
            return (_local_1);
        }

        override protected function initClassDefaults(_arg_1:UIDefaults):void
        {
            var _local_2:Array = ["ButtonUI", BasicButtonUI, "PanelUI", BasicPanelUI, "ToggleButtonUI", BasicToggleButtonUI, "RadioButtonUI", BasicRadioButtonUI, "CheckBoxUI", BasicCheckBoxUI, "ColorSwatchesUI", BasicColorSwatchesUI, "ColorMixerUI", BasicColorMixerUI, "ColorChooserUI", BasicColorChooserUI, "ScrollBarUI", BasicScrollBarUI, "SeparatorUI", BasicSeparatorUI, "ViewportUI", BasicViewportUI, "ScrollPaneUI", BasicScrollPaneUI, "LabelUI", BasicLabelUI, "TextFieldUI", BasicTextFieldUI, "TextAreaUI", BasicTextAreaUI, "FrameUI", BasicFrameUI, "ToolTipUI", BasicToolTipUI, "ProgressBarUI", BasicProgressBarUI, "ListUI", BasicListUI, "ComboBoxUI", BasicComboBoxUI, "SliderUI", BasicSliderUI, "AdjusterUI", BasicAdjusterUI, "AccordionUI", BasicAccordionUI, "TabbedPaneUI", BasicTabbedPaneUI, "SplitPaneUI", BasicSplitPaneUI, "SpacerUI", BasicSpacerUI, "TableUI", BasicTableUI, "TableHeaderUI", BasicTableHeaderUI, "TreeUI", BasicTreeUI, "StepperUI", BasicStepperUI, "ToolBarUI", BasicToolBarUI];
            _arg_1.putDefaults(_local_2);
        }

        override protected function initSystemColorDefaults(_arg_1:UIDefaults):void
        {
            var _local_2:Array = ["window", 6974063, "windowText", 16777214, "menu", 0xEAEAEA, "menuText", 0x5D5D5D, "control", 0, "controlMide", 3127274, "controlText", 13421796, "selectionForeground", 0xFFFFFF];
            var _local_3:Number = 0;
            while (_local_3 < _local_2.length)
            {
                _arg_1.put(_local_2[_local_3], new ASColorUIResource(_local_2[(_local_3 + 1)]));
                _local_3 = (_local_3 + 2);
            };
            _arg_1.put("selectionBackground", new ASColorUIResource(6776698, 0.9));
            _arg_1.put("focusInner", new ASColorUIResource(4259648, 0.3));
            _arg_1.put("focusOutter", new ASColorUIResource(4259648, 0.4));
        }

        override protected function initSystemFontDefaults(_arg_1:UIDefaults):void
        {
            var _local_2:Array = ["systemFont", new ASFontUIResource("Arial", 12), "menuFont", new ASFontUIResource("Arial", 12), "controlFont", new ASFontUIResource("Arial", 12, false), "windowFont", new ASFontUIResource("Arial", 12, true)];
            _arg_1.putDefaults(_local_2);
        }

        override protected function initCommonUtils(_arg_1:UIDefaults):void
        {
            ResizerController.setDefaultResizerClass(DefaultResizer);
            var _local_2:Array = ["resizeArrow", new ASColorUIResource(5095888), "resizeArrowLight", new ASColorUIResource(10674150), "resizeArrowDark", new ASColorUIResource(2790817)];
            _arg_1.putDefaults(_local_2);
            var _local_3:Array = ["System.hResizeCursor", H_ResizeCursor, "System.vResizeCursor", V_ResizeCursor, "System.hvResizeCursor", HV_ResizeCursor, "System.hMoveCursor", H_ResizeCursor, "System.vMoveCursor", V_ResizeCursor, "System.hvMoveCursor", HV_ResizeCursor];
            _arg_1.putDefaults(_local_3);
        }

        override protected function initComponentDefaults(_arg_1:UIDefaults):void
        {
            var _local_4:ASFont;
            var _local_2:ASColorUIResource = new ASColorUIResource(5143717);
            var _local_3:ASColorUIResource = new ASColorUIResource(0xE5E5E5);
            _local_4 = _arg_1.getFont("controlFont");
            var _local_5:ASFont = new ASFont(_local_4.getName(), 12, true);
            var _local_6:Array = ["Button.background", new ASColorUIResource(7104092), "Button.foreground", new ASColorUIResource(16767612), "Button.mideground", _arg_1.get("controlMide"), "Button.colorAdjust", new UIStyleTune(0.18, 0.05, 0.2, 0.2, 5), "Button.opaque", true, "Button.focusable", true, "Button.font", _local_5, "Button.bg", ButtonBackground, "Button.margin", new InsetsUIResource(2, 3, 5, 3), "Button.textShiftOffset", 0, "Button.textFilters", new ArrayUIResource([new DropShadowFilter(1, 45, 0, 0.3, 1, 1, 1, 1)])];
            _arg_1.putDefaults(_local_6);
            _local_6 = ["LabelButton.background", _local_2, "LabelButton.foreground", new ASColorUIResource(22039), "LabelButton.mideground", _arg_1.get("controlMide"), "LabelButton.colorAdjust", new UIStyleTune(0.26, 0.05, 0.2, 0.2), "LabelButton.opaque", false, "LabelButton.focusable", true, "LabelButton.font", _arg_1.getFont("controlFont"), "LabelButton.margin", new InsetsUIResource(0, 0, 0, 0), "LabelButton.textShiftOffset", 0];
            _arg_1.putDefaults(_local_6);
            _local_6 = ["Panel.background", _arg_1.get("window"), "Panel.foreground", _arg_1.get("windowText"), "Panel.mideground", _arg_1.get("controlMide"), "Panel.colorAdjust", new UIStyleTune(0.18, 0.05, 0.2, 0.2), "Panel.opaque", false, "Panel.focusable", false, "Panel.bg", PanelBackground, "Panel.font", _arg_1.getFont("windowFont")];
            _arg_1.putDefaults(_local_6);
            _local_6 = ["ToggleButton.background", _local_2, "ToggleButton.foreground", new ASColorUIResource(16777214), "ToggleButton.mideground", _arg_1.get("controlMide"), "ToggleButton.colorAdjust", new UIStyleTune(0.18, -0.02, 0.34, 0.22, 5), "ToggleButton.opaque", true, "ToggleButton.focusable", true, "ToggleButton.font", _arg_1.getFont("controlFont"), "ToggleButton.bg", ToggleButtonBackground, "ToggleButton.margin", new InsetsUIResource(2, 3, 5, 3), "ToggleButton.textShiftOffset", 1, "ToggleButton.textFilters", new ArrayUIResource([new DropShadowFilter(1, 45, 0, 0.3, 1, 1, 1, 1)])];
            _arg_1.putDefaults(_local_6);
            _local_6 = ["RadioButton.background", new ASColorUIResource(14804453), "RadioButton.foreground", _arg_1.get("controlText"), "RadioButton.mideground", new ASColorUIResource(3780607), "RadioButton.colorAdjust", new UIStyleTune(0.8, 0.01, 0.4, 0.3, 0, new UIStyleTune(0.4, 0.1, 0.1, 0)), "RadioButton.opaque", false, "RadioButton.focusable", true, "RadioButton.font", _arg_1.getFont("controlFont"), "RadioButton.icon", RadioButtonIcon, "RadioButton.margin", new InsetsUIResource(0, 0, 0, 0), "RadioButton.textShiftOffset", 0, "RadioButton.textFilters", new ArrayUIResource()];
            _arg_1.putDefaults(_local_6);
            _local_6 = ["CheckBox.background", new ASColorUIResource(14804453), "CheckBox.foreground", _arg_1.get("controlText"), "CheckBox.mideground", new ASColorUIResource(3780607), "CheckBox.colorAdjust", new UIStyleTune(0.8, 0.01, 0.4, 0.3, 2, new UIStyleTune(0.5, -0.2, 0.5, 0.7)), "CheckBox.opaque", false, "CheckBox.focusable", true, "CheckBox.font", _arg_1.getFont("controlFont"), "CheckBox.icon", CheckBoxIcon, "CheckBox.margin", new InsetsUIResource(0, 0, 0, 0), "CheckBox.textShiftOffset", 0, "CheckBox.textFilters", new ArrayUIResource()];
            _arg_1.putDefaults(_local_6);
            _local_6 = ["Separator.background", new ASColorUIResource(3507061, 0.3), "Separator.foreground", NULL_COLOR, "Separator.mideground", NULL_COLOR, "Separator.colorAdjust", new UIStyleTune(0.18, 0.05, 0.2, 0.2), "Separator.opaque", false, "Separator.focusable", false];
            _arg_1.putDefaults(_local_6);
            _local_6 = ["ScrollBar.background", new ASColorUIResource(0xA8A8A8, 0.3), "ScrollBar.foreground", _arg_1.get("controlText"), "ScrollBar.mideground", new ASColorUIResource(8422281, 0.8), "ScrollBar.colorAdjust", new UIStyleTune(0.18, 0.08, 0.2, 0.5, 2, new UIStyleTune(0.08, -0.3, 0.08, 0.2, 2)), "ScrollBar.opaque", true, "ScrollBar.focusable", true, "ScrollBar.barWidth", 14, "ScrollBar.minimumThumbLength", 24, "ScrollBar.font", _arg_1.getFont("controlFont"), "ScrollBar.bg", ScrollBarBackground, "ScrollBar.thumbDecorator", ScrollBarThumb];
            _arg_1.putDefaults(_local_6);
            _local_6 = ["ScrollPane.background", _arg_1.get("window"), "ScrollPane.foreground", _arg_1.get("windowText"), "ScrollPane.mideground", _arg_1.get("controlMide"), "ScrollPane.colorAdjust", new UIStyleTune(0.18, 0.05, 0.2, 0.2), "ScrollPane.opaque", false, "ScrollPane.focusable", false, "ScrollPane.font", _arg_1.getFont("windowFont")];
            _arg_1.putDefaults(_local_6);
            _local_6 = ["ProgressBar.background", new ASColorUIResource(0xB5B5B5, 0.3), "ProgressBar.foreground", _arg_1.get("windowText"), "ProgressBar.mideground", new ASColorUIResource(13563487), "ProgressBar.colorAdjust", new UIStyleTune(0.18, 0.05, 0.2, 0.5, 4, new UIStyleTune(0.34, -0.4, 0.01, 0.5, 4)), "ProgressBar.opaque", true, "ProgressBar.focusable", false, "ProgressBar.barWidth", 11, "ProgressBar.font", new ASFontUIResource("Tahoma", 9), "ProgressBar.bg", ProgressBarBackground, "ProgressBar.fg", ProgressBarIcon, "ProgressBar.progressColor", new ASColorUIResource(3368652), "ProgressBar.indeterminateDelay", 40];
            _arg_1.putDefaults(_local_6);
            _local_6 = ["Viewport.background", _arg_1.get("window"), "Viewport.foreground", _arg_1.get("windowText"), "Viewport.mideground", _arg_1.get("controlMide"), "Viewport.colorAdjust", new UIStyleTune(0.18, 0.05, 0.2, 0.2), "Viewport.opaque", false, "Viewport.focusable", true, "Viewport.font", _arg_1.getFont("windowFont")];
            _arg_1.putDefaults(_local_6);
            _local_6 = ["Label.background", _arg_1.get("control"), "Label.foreground", _arg_1.get("controlText"), "Label.mideground", _arg_1.get("controlMide"), "Label.colorAdjust", new UIStyleTune(0.18, 0.05, 0.2, 0.2), "Label.opaque", false, "Label.focusable", false, "Label.font", _arg_1.getFont("controlFont")];
            _arg_1.putDefaults(_local_6);
            _local_6 = ["TextField.background", _local_3, "TextField.foreground", new ASColorUIResource(4210768), "TextField.mideground", new ASColorUIResource(0x89BB00), "TextField.colorAdjust", new UIStyleTune(0, -0.3, 0, 0.3, 3), "TextField.opaque", true, "TextField.focusable", true, "TextField.font", _arg_1.getFont("controlFont"), "TextField.bg", TextComponentBackBround, "TextField.border", new EmptyBorderResource(null, new Insets(1, 3, 2, 3))];
            _arg_1.putDefaults(_local_6);
            _local_6 = ["TextArea.background", _local_3, "TextArea.foreground", new ASColorUIResource(14737648), "TextArea.mideground", new ASColorUIResource(0x89BB00), "TextArea.colorAdjust", new UIStyleTune(0, -0.3, 0, 0.3, 3), "TextArea.opaque", true, "TextArea.focusable", true, "TextArea.font", _arg_1.getFont("controlFont"), "TextArea.bg", TextComponentBackBround, "TextArea.border", new EmptyBorderResource(null, new Insets(1, 3, 2, 3))];
            _arg_1.putDefaults(_local_6);
            _local_6 = ["Frame.background", new ASColorUIResource(4280421), "Frame.foreground", new ASColorUIResource(0xFFFFFF), "Frame.mideground", new ASColorUIResource(12632271), "Frame.colorAdjust", new UIStyleTune(0.1, 0, 0, 0.8, 6, new UIStyleTune(0.1, 0, 0, 0.6, 6)), "Frame.opaque", true, "Frame.focusable", true, "Frame.dragDirectly", true, "Frame.resizeArrow", new ASColorUIResource(4214880), "Frame.resizeArrowLight", new ASColorUIResource(14869214), "Frame.resizeArrowDark", new ASColorUIResource(3042698), "Frame.resizer", DefaultResizer, "Frame.font", _arg_1.get("windowFont"), "Frame.resizerMargin", new InsetsUIResource(2, 1, 6, 6), "Frame.bg", FrameBackground, "Frame.border", new EmptyBorderResource(null, new Insets(0, 6, 12, 12)), "Frame.icon", TitleIcon, "Frame.iconifiedIcon", FrameIconifiedIcon, "Frame.normalIcon", FrameNormalIcon, "Frame.maximizeIcon", FrameMaximizeIcon, "Frame.closeIcon", FrameCloseIcon];
            _arg_1.putDefaults(_local_6);
            _local_6 = ["FrameTitleBar.background", new ASColorUIResource(12902502), "FrameTitleBar.foreground", new ASColorUIResource(7377056), "FrameTitleBar.mideground", new ASColorUIResource(10529460), "FrameTitleBar.colorAdjust", new UIStyleTune(0.24, 0.02, 0.18, 0.5, 0, new UIStyleTune(0.2, -0.28, 0.08, 0.1, 1)), "FrameTitleBar.opaque", true, "FrameTitleBar.focusable", false, "FrameTitleBar.titleBarHeight", 25, "FrameTitleBar.buttonGap", 2, "FrameTitleBar.font", _arg_1.get("windowFont"), "FrameTitleBar.border", new EmptyBorderResource(null, new Insets(7, 0, 0, 0)), "FrameTitleBar.icon", TitleIcon, "FrameTitleBar.iconifiedIcon", FrameIconifiedIcon, "FrameTitleBar.normalIcon", FrameNormalIcon, "FrameTitleBar.maximizeIcon", FrameMaximizeIcon, "FrameTitleBar.closeIcon", FrameCloseIcon];
            _arg_1.putDefaults(_local_6);
            _local_6 = ["ToolTip.background", new ASColorUIResource(1383206), "ToolTip.foreground", new ASColorUIResource(14737648), "ToolTip.mideground", new ASColorUIResource(10790311), "ToolTip.colorAdjust", new UIStyleTune(0.18, 0.05, 0.2, 0.2, 2), "ToolTip.opaque", true, "ToolTip.focusable", false, "ToolTip.font", _arg_1.getFont("controlFont"), "ToolTip.bg", ToolTipBackground, "ToolTip.border", new EmptyBorderResource(null, new Insets(5, 8, 5, 8))];
            _arg_1.putDefaults(_local_6);
            _local_6 = ["List.font", _arg_1.getFont("controlFont"), "List.background", new ASColorUIResource(3376538, 0), "List.foreground", _arg_1.get("controlText"), "List.mideground", new ASColorUIResource(3376794), "List.colorAdjust", new UIStyleTune(0.08, 0.05, 0.2, 0.2, 0), "List.opaque", false, "List.focusable", true, "List.bg", ListBackground, "List.selectionBackground", _arg_1.get("selectionBackground"), "List.selectionForeground", _arg_1.get("selectionForeground")];
            _arg_1.putDefaults(_local_6);
            _local_6 = ["SplitPane.background", new ASColorUIResource(2515580), "SplitPane.foreground", new ASColorUIResource(5287642), "SplitPane.mideground", _arg_1.get("controlMide"), "SplitPane.colorAdjust", new UIStyleTune(0.18, 0.05, 0.2, 0.2), "SplitPane.opaque", false, "SplitPane.focusable", true, "SplitPane.defaultDividerSize", 10, "SplitPane.font", _arg_1.getFont("windowFont"), "SplitPane.border", undefined, "SplitPane.presentDragColor", new ASColorUIResource(4560312, 0.4)];
            _arg_1.putDefaults(_local_6);
            _local_6 = ["Spacer.background", _arg_1.get("window"), "Spacer.foreground", _arg_1.get("window"), "Spacer.mideground", _arg_1.get("controlMide"), "Spacer.colorAdjust", new UIStyleTune(0.18, 0.05, 0.2, 0.2), "Spacer.opaque", false, "Spacer.focusable", false];
            _arg_1.putDefaults(_local_6);
            _local_6 = ["ComboBox.font", _arg_1.getFont("controlFont"), "ComboBox.background", _local_3, "ComboBox.foreground", _arg_1.get("controlText"), "ComboBox.mideground", new ASColorUIResource(0x89BB00), "ComboBox.colorAdjust", new UIStyleTune(0, -0.3, 0, 0.32, 3, new UIStyleTune(0.04, 0.05, 0.2, 0.1)), "ComboBox.opaque", true, "ComboBox.focusable", true, "ComboBox.popupBorder", ComboBoxPopupBorder, "ComboBox.bg", InputBackground, "ComboBox.border", new EmptyBorderResource(null, new Insets(1, 3, 2, 3))];
            _arg_1.putDefaults(_local_6);
            _local_6 = ["Slider.font", _arg_1.getFont("controlFont"), "Slider.background", new ASColorUIResource(7334137, 0.34), "Slider.foreground", _arg_1.get("controlText"), "Slider.mideground", _arg_1.get("controlMide"), "Slider.colorAdjust", new UIStyleTune(0.18, 0.05, 0.2, 0.5, 6, new UIStyleTune(0.2, 0, 0.4, 0, 0)), "Slider.opaque", false, "Slider.focusable", true, "Slider.thumbIcon", SliderThumbIcon];
            _arg_1.putDefaults(_local_6);
            _local_6 = ["Adjuster.background", _local_3, "Adjuster.foreground", new ASColorUIResource(0x101010), "Adjuster.mideground", new ASColorUIResource(0x89BB00), "Adjuster.colorAdjust", new UIStyleTune(0, -0.3, 0, 0.32, 3, new UIStyleTune(0.04, 0.05, 0.2, 0.1)), "Adjuster.opaque", true, "Adjuster.focusable", true, "Adjuster.font", _arg_1.getFont("controlFont"), "Adjuster.thumbIcon", PopupSliderThumbIcon, "Adjuster.bg", InputBackground, "Adjuster.border", new EmptyBorderResource(null, new Insets(1, 3, 2, 3))];
            _arg_1.putDefaults(_local_6);
            _local_6 = ["Stepper.font", _arg_1.getFont("controlFont"), "Stepper.background", _local_3, "Stepper.foreground", _arg_1.get("controlText"), "Stepper.mideground", new ASColorUIResource(0x89BB00), "Stepper.colorAdjust", new UIStyleTune(0, -0.3, 0, 0.32, 3, new UIStyleTune(0.04, 0.05, 0.2, 0.1)), "Stepper.opaque", true, "Stepper.focusable", true, "Stepper.bg", InputBackground, "Stepper.border", new EmptyBorderResource(null, new Insets(1, 3, 2, 3))];
            _arg_1.putDefaults(_local_6);
            _local_6 = ["ColorSwatches.background", new ASColorUIResource(0xEEEEEE), "ColorSwatches.foreground", _arg_1.get("controlText"), "ColorSwatches.mideground", _arg_1.get("controlMide"), "ColorSwatches.colorAdjust", new UIStyleTune(0.18, 0.05, 0.2, 0.2), "ColorSwatches.opaque", false, "ColorSwatches.focusable", false, "ColorSwatches.font", _arg_1.getFont("controlFont"), "ColorSwatches.border", undefined];
            _arg_1.putDefaults(_local_6);
            _local_6 = ["ColorMixer.background", new ASColorUIResource(0xEEEEEE), "ColorMixer.foreground", _arg_1.get("controlText"), "ColorMixer.mideground", _arg_1.get("controlMide"), "ColorMixer.colorAdjust", new UIStyleTune(0.18, 0.05, 0.2, 0.2), "ColorMixer.opaque", false, "ColorMixer.focusable", false, "ColorMixer.font", _arg_1.getFont("controlFont"), "ColorMixer.border", undefined];
            _arg_1.putDefaults(_local_6);
            _local_6 = ["ColorChooser.background", _arg_1.get("window"), "ColorChooser.foreground", _arg_1.get("controlText"), "ColorChooser.mideground", _arg_1.get("controlMide"), "ColorChooser.colorAdjust", new UIStyleTune(0.18, 0.05, 0.2, 0.2), "ColorChooser.opaque", false, "ColorChooser.focusable", false, "ColorChooser.font", _arg_1.getFont("controlFont"), "ColorChooser.border", ColorChooserBorder];
            _arg_1.putDefaults(_local_6);
            _local_6 = ["Accordion.font", _arg_1.getFont("controlFont"), "Accordion.background", _arg_1.get("window"), "Accordion.foreground", new ASColorUIResource(16777214), "Accordion.mideground", _arg_1.get("controlMide"), "Accordion.colorAdjust", new UIStyleTune(0.18, 0.05, 0.2, 0.2), "Accordion.opaque", false, "Accordion.focusable", true, "Accordion.motionSpeed", 50, "Accordion.tabMargin", new InsetsUIResource(2, 3, 3, 2)];
            _arg_1.putDefaults(_local_6);
            _local_6 = ["TabbedPane.background", _arg_1.get("window"), "TabbedPane.foreground", _arg_1.get("controlText"), "TabbedPane.mideground", new ASColorUIResource(0x4A4A4A), "TabbedPane.colorAdjust", new UIStyleTune(0.01, -0.14, 0.01, 0.5, 4, new UIStyleTune(0.05, -0.23, 0.01, 0.5, 4)), "TabbedPane.opaque", false, "TabbedPane.focusable", true, "TabbedPane.arrowShadowColor", new ASColorUIResource(0), "TabbedPane.arrowLightColor", new ASColorUIResource(0x444444), "TabbedPane.font", _arg_1.getFont("controlFont"), "TabbedPane.tabMargin", new InsetsUIResource(3, 8, 2, 8), "TabbedPane.contentMargin", new InsetsUIResource(10, 2, 2, 2), "TabbedPane.selectedTabExpandInsets", new InsetsUIResource(0, 0, 0, 0), "TabbedPane.tabBorderInsets", new InsetsUIResource(0, 0, 0, 0), "TabbedPane.contentRoundLineThickness", 0, "TabbedPane.tabGap", 2, "TabbedPane.topBlankSpace", 0, "TabbedPane.maxTabWidth", 1000];
            _arg_1.putDefaults(_local_6);
            _local_6 = ["ClosableTabbedPane.background", new ASColorUIResource(15198181), "ClosableTabbedPane.foreground", _arg_1.get("controlText"), "ClosableTabbedPane.mideground", new ASColorUIResource(5095888), "ClosableTabbedPane.colorAdjust", new UIStyleTune(0.01, -0.24, 0.01, 0.5, 4), "ClosableTabbedPane.opaque", false, "ClosableTabbedPane.focusable", true, "ClosableTabbedPane.shadow", new ASColorUIResource(0x888888), "ClosableTabbedPane.darkShadow", new ASColorUIResource(0x444444), "ClosableTabbedPane.light", _arg_1.getColor("controlHighlight"), "ClosableTabbedPane.highlight", new ASColorUIResource(0xFFFFFF), "ClosableTabbedPane.arrowShadowColor", new ASColorUIResource(0), "ClosableTabbedPane.arrowLightColor", new ASColorUIResource(0x444444), "ClosableTabbedPane.font", _arg_1.getFont("controlFont"), "ClosableTabbedPane.tabMargin", new InsetsUIResource(2, 3, 1, 3), "ClosableTabbedPane.contentMargin", new InsetsUIResource(8, 2, 2, 2), "ClosableTabbedPane.contentRoundLineThickness", 2, "ClosableTabbedPane.topBlankSpace", 4, "ClosableTabbedPane.maxTabWidth", 1000];
            _arg_1.putDefaults(_local_6);
            _local_6 = ["Table.background", new ASColorUIResource(3182497, 0), "Table.foreground", _arg_1.get("controlText"), "Table.mideground", new ASColorUIResource(3618620), "Table.colorAdjust", new UIStyleTune(0.1, -0.2, 0.1, 0.2, 0), "Table.opaque", true, "Table.focusable", true, "Table.font", _arg_1.getFont("controlFont"), "Table.selectionBackground", _arg_1.get("selectionBackground"), "Table.selectionForeground", _arg_1.get("selectionForeground"), "Table.gridColor", new ASColorUIResource(0x505050), "Table.bg", TableBackground, "Table.border", new EmptyBorderResource(null, new Insets(2, 2, 2, 2))];
            _arg_1.putDefaults(_local_6);
            _local_6 = ["TableHeader.font", _arg_1.getFont("controlFont"), "TableHeader.background", new ASColorUIResource(8421520), "TableHeader.foreground", new ASColorUIResource(2434368), "TableHeader.mideground", new ASColorUIResource(0x9D9D9D), "TableHeader.colorAdjust", new UIStyleTune(0.06, 0.2, 0.1, 0.5, 0, new UIStyleTune(0.04, 0.05, 0.2, 0.1)), "TableHeader.opaque", true, "TableHeader.focusable", true, "TableHeader.gridColor", new ASColorUIResource(0xD6D6D6), "TableHeader.bg", TableHeaderBackground, "TableHeader.border", undefined, "TableHeader.cellBorder", TableHeaderCellBorder, "TableHeader.sortableCellBorder", TableHeaderCellBorder];
            _arg_1.putDefaults(_local_6);
            _local_6 = ["Tree.background", new ASColorUIResource(3376538, 0), "Tree.foreground", _arg_1.get("controlText"), "Tree.mideground", _arg_1.get("controlMide"), "Tree.colorAdjust", new UIStyleTune(0.18, 0.05, 0.2, 0.2), "Tree.opaque", false, "Tree.focusable", true, "Tree.font", _arg_1.getFont("controlFont"), "Tree.selectionBackground", _arg_1.get("selectionBackground"), "Tree.selectionForeground", _arg_1.get("selectionForeground"), "Tree.leafIcon", TreeLeafIcon, "Tree.folderExpandedIcon", TreeFolderIcon, "Tree.folderCollapsedIcon", TreeFolderIcon, "Tree.leftChildIndent", 10, "Tree.rightChildIndent", 0, "Tree.rowHeight", 16, "Tree.expandControl", BasicExpandControl, "Tree.border", undefined];
            _arg_1.putDefaults(_local_6);
            _local_6 = ["ToolBar.background", _arg_1.get("window"), "ToolBar.foreground", _arg_1.get("windowText"), "ToolBar.mideground", _arg_1.get("controlMide"), "ToolBar.colorAdjust", new UIStyleTune(0.18, 0.05, 0.2, 0.2), "ToolBar.opaque", true, "ToolBar.focusable", false];
            _arg_1.putDefaults(_local_6);
            _local_6 = ["MenuItem.background", _arg_1.get("menu"), "MenuItem.foreground", _arg_1.get("menuText"), "MenuItem.mideground", _arg_1.get("controlMide"), "MenuItem.colorAdjust", new UIStyleTune(0, 0, 0, 0, 2), "MenuItem.opaque", false, "MenuItem.focusable", false, "MenuItem.font", _arg_1.getFont("menuFont"), "MenuItem.selectionBackground", _arg_1.get("selectionBackground"), "MenuItem.selectionForeground", _arg_1.get("selectionForeground"), "MenuItem.disabledForeground", new ASColorUIResource(0x888888), "MenuItem.acceleratorFont", _arg_1.getFont("menuFont"), "MenuItem.acceleratorForeground", _arg_1.get("menuText"), "MenuItem.acceleratorSelectionForeground", _arg_1.get("menu"), "MenuItem.border", undefined, "MenuItem.arrowIcon", MenuItemArrowIcon, "MenuItem.checkIcon", MenuItemCheckIcon, "MenuItem.margin", new InsetsUIResource(0, 0, 0, 0)];
            _arg_1.putDefaults(_local_6);
            _local_6 = ["CheckBoxMenuItem.background", _arg_1.get("menu"), "CheckBoxMenuItem.foreground", _arg_1.get("menuText"), "CheckBoxMenuItem.mideground", new ASColorUIResource(0x5D5D5D), "CheckBoxMenuItem.colorAdjust", new UIStyleTune(0, 0, 0, 0, 2), "CheckBoxMenuItem.opaque", false, "CheckBoxMenuItem.focusable", false, "CheckBoxMenuItem.font", _arg_1.getFont("menuFont"), "CheckBoxMenuItem.selectionBackground", _arg_1.get("selectionBackground"), "CheckBoxMenuItem.selectionForeground", _arg_1.get("selectionForeground"), "CheckBoxMenuItem.disabledForeground", new ASColorUIResource(0x888888), "CheckBoxMenuItem.acceleratorFont", _arg_1.getFont("menuFont"), "CheckBoxMenuItem.acceleratorForeground", _arg_1.get("menuText"), "CheckBoxMenuItem.acceleratorSelectionForeground", _arg_1.get("menu"), "CheckBoxMenuItem.border", undefined, "CheckBoxMenuItem.arrowIcon", MenuItemArrowIcon, "CheckBoxMenuItem.checkIcon", CheckBoxMenuItemCheckIcon, "CheckBoxMenuItem.margin", new InsetsUIResource(0, 0, 0, 0)];
            _arg_1.putDefaults(_local_6);
            _local_6 = ["RadioButtonMenuItem.background", _arg_1.get("menu"), "RadioButtonMenuItem.foreground", _arg_1.get("menuText"), "RadioButtonMenuItem.mideground", new ASColorUIResource(0x5D5D5D), "RadioButtonMenuItem.colorAdjust", new UIStyleTune(0, 0, 0, 0, 2), "RadioButtonMenuItem.opaque", false, "RadioButtonMenuItem.focusable", false, "RadioButtonMenuItem.font", _arg_1.getFont("menuFont"), "RadioButtonMenuItem.selectionBackground", _arg_1.get("selectionBackground"), "RadioButtonMenuItem.selectionForeground", _arg_1.get("selectionForeground"), "RadioButtonMenuItem.disabledForeground", new ASColorUIResource(0x888888), "RadioButtonMenuItem.acceleratorFont", _arg_1.getFont("menuFont"), "RadioButtonMenuItem.acceleratorForeground", _arg_1.get("menuText"), "RadioButtonMenuItem.acceleratorSelectionForeground", _arg_1.get("menu"), "RadioButtonMenuItem.border", undefined, "RadioButtonMenuItem.arrowIcon", MenuItemArrowIcon, "RadioButtonMenuItem.checkIcon", RadioButtonMenuItemCheckIcon, "RadioButtonMenuItem.margin", new InsetsUIResource(0, 0, 0, 0)];
            _arg_1.putDefaults(_local_6);
            _local_6 = ["Menu.background", _arg_1.get("menu"), "Menu.foreground", _arg_1.get("menuText"), "Menu.mideground", new ASColorUIResource(0x5D5D5D), "Menu.colorAdjust", new UIStyleTune(0, 0, 0, 0, 2), "Menu.opaque", false, "Menu.focusable", false, "Menu.font", _arg_1.getFont("menuFont"), "Menu.selectionBackground", _arg_1.get("selectionBackground"), "Menu.selectionForeground", _arg_1.get("selectionForeground"), "Menu.disabledForeground", new ASColorUIResource(0x888888), "Menu.acceleratorFont", _arg_1.getFont("menuFont"), "Menu.acceleratorForeground", _arg_1.get("menuText"), "Menu.acceleratorSelectionForeground", _arg_1.get("menu"), "Menu.border", undefined, "Menu.arrowIcon", MenuArrowIcon, "Menu.checkIcon", MenuCheckIcon, "Menu.margin", new InsetsUIResource(0, 0, 0, 0), "Menu.useMenuBarBackgroundForTopLevel", true, "Menu.menuPopupOffsetX", 0, "Menu.menuPopupOffsetY", 0, "Menu.submenuPopupOffsetX", -4, "Menu.submenuPopupOffsetY", 0];
            _arg_1.putDefaults(_local_6);
            _local_6 = ["PopupMenu.background", new ASColorUIResource(0xF0F0F0, 0.95), "PopupMenu.foreground", _arg_1.get("menuText"), "PopupMenu.mideground", _arg_1.get("controlMide"), "PopupMenu.colorAdjust", new UIStyleTune(0.14, -0.14, 0.06, 0.2, 0), "PopupMenu.opaque", true, "PopupMenu.focusable", false, "PopupMenu.font", _arg_1.getFont("menuFont"), "PopupMenu.borderColor", _arg_1.get("controlDkShadow"), "PopupMenu.border", PopupMenuBorder];
            _arg_1.putDefaults(_local_6);
            _local_6 = ["MenuBar.background", _arg_1.get("menu"), "MenuBar.foreground", _arg_1.get("menuText"), "MenuBar.mideground", _arg_1.get("controlMide"), "MenuBar.colorAdjust", new UIStyleTune(0.18, 0.05, 0.2, 0.2), "MenuBar.opaque", false, "MenuBar.focusable", true, "MenuBar.font", _arg_1.getFont("menuFont"), "MenuBar.border", undefined];
            _arg_1.putDefaults(_local_6);
        }


    }
}//package hbm.Game.GUI

