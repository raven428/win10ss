using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using W10SS_GUI.Controls;
using System.IO;
using System.Windows.Media.Animation;

namespace W10SS_GUI
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        internal class Culture
        {
            internal const string EN = "en";
            internal const string RU = "ru";
        }       

        private static string _culture = Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName == Culture.RU ? Culture.RU : Culture.EN;
        private HamburgerCategoryButton _lastclickedbutton;
        private Dictionary<string, StackPanel> _togglesCategoryAndPanels = new Dictionary<string, StackPanel>();

        internal string LastClickedButtonName => _lastclickedbutton.Name as string;
        private uint TogglesCounter = default(uint);                
        private List<ToggleSwitch> TogglesSwitches = new List<ToggleSwitch>();
        private static ResourceDictionary resourceDictionaryEn = new ResourceDictionary() { Source = new Uri("pack://application:,,,/Localized/EN.xaml", UriKind.Absolute) };
        private static ResourceDictionary resourceDictionaryRu = new ResourceDictionary() { Source = new Uri("pack://application:,,,/Localized/RU.xaml", UriKind.Absolute) };

        public MainWindow()
        {
            InitializeComponent();            
        }

        private void InitializeVariables()
        {
            foreach (var tagValue in Application.Current.Resources.MergedDictionaries.Where(r => r.Source.LocalPath == "/Resource/tags.xaml").First().Values)
            {
                _togglesCategoryAndPanels.Add(tagValue.ToString(), panelTogglesCategoryContainer.Children.OfType<StackPanel>().Where(p => p.Tag == tagValue).First());
            }
        }
        
        private void SetUiLanguage()
        {
            Resources.MergedDictionaries.Add(GetCurrentCulture());                
        }

        internal static ResourceDictionary GetCurrentCulture() => _culture == Culture.RU ? resourceDictionaryRu : resourceDictionaryEn;

        internal static string GetCurrentCultureName() => _culture == Culture.RU ? Culture.RU : Culture.EN;

        internal static ResourceDictionary ChangeCulture()
        {
            _culture = _culture == Culture.RU ? Culture.EN : Culture.RU;
            return _culture == Culture.RU ? resourceDictionaryRu : resourceDictionaryEn;
        }

        private void InitializeToggles()
        {
            for (int i = 0; i < _togglesCategoryAndPanels.Keys.Count; i++)
            {
                string categoryName = _togglesCategoryAndPanels.Keys.ToList()[i];
                StackPanel categoryPanel = _togglesCategoryAndPanels[categoryName];
                string psScriptsDir = System.IO.Path.Combine(AppDomain.CurrentDomain.BaseDirectory, categoryName);

                List<ToggleSwitch> togglesSwitches = Directory.Exists(psScriptsDir)
                    && Directory.EnumerateFiles(psScriptsDir, "*.*", SearchOption.AllDirectories)
                                .Where(f => f.EndsWith(".ps1"))
                                .Count() > 0

                    ? Directory.EnumerateFiles(psScriptsDir, "*.*", SearchOption.AllDirectories)
                               .Where(f => f.EndsWith(".ps1"))
                               .Select(f => CreateToogleSwitchFromScript(f))
                               .ToList()
                    : null;

                togglesSwitches?.Where(t => t.IsValid == true).ToList().ForEach(t => categoryPanel.Children.Add(t));
            }
        }

        private ToggleSwitch CreateToogleSwitchFromScript(string scriptPath)
        {
            string dictionaryHeaderID = $"ToggleHeader-{TogglesCounter}";
            string dictionaryDescriptionID = $"ToggleDescription-{TogglesCounter}";
            string[] arrayLines = new string[4];

            ResourceDictionary dictionaryEN = new ResourceDictionary()
            {
                Source = new Uri("/Localized/EN.xaml", UriKind.Relative)
            };

            ResourceDictionary dictionaryRU = new ResourceDictionary()
            {
                Source = new Uri("/Localized/RU.xaml", UriKind.Relative)
            };

            ToggleSwitch toggleSwitch = new ToggleSwitch()
            {
                ScriptPath = scriptPath
            };

            try
            {
                using (StreamReader streamReader = new StreamReader(scriptPath, Encoding.UTF8))
                {
                    for (int i = 0; i < 4; i++)
                    {
                        string textLine = streamReader.ReadLine();
                        toggleSwitch.IsValid = textLine.StartsWith("# ") && textLine.Length >= 10 ? true : false;
                        arrayLines[i] = textLine.Replace("# ", "");
                    }
                }
            }
            catch (Exception)
            {

            }

            dictionaryEN.Add(dictionaryHeaderID, arrayLines[0]);
            dictionaryEN.Add(dictionaryDescriptionID, arrayLines[1]);

            //dictionaryEN[dictionaryHeaderID] = arrayLines[0];
            //dictionaryEN[dictionaryDescriptionID] = arrayLines[1];
            //dictionaryRU[dictionaryHeaderID] = arrayLines[2];
            //dictionaryRU[dictionaryDescriptionID] = arrayLines[3];

            toggleSwitch.SetResourceReference(ToggleSwitch.HeaderProperty, dictionaryHeaderID);
            toggleSwitch.SetResourceReference(ToggleSwitch.DescriptionProperty, dictionaryDescriptionID);

            TogglesCounter++;
            TogglesSwitches.Add(toggleSwitch);
            return toggleSwitch;
        }

        internal void SetActivePanel(HamburgerCategoryButton button)
        {
            _lastclickedbutton = button;

            foreach (KeyValuePair<string, StackPanel> kvp in _togglesCategoryAndPanels)
            {
                kvp.Value.Visibility = kvp.Key == button.Tag as string ? Visibility.Visible : Visibility.Collapsed;
            }

            textTogglesHeader.Text = Resources[button.Name] as string;
        }

        internal void HamburgerReOpen()
        {
            MouseEventArgs mouseLeaveArgs = new MouseEventArgs(Mouse.PrimaryDevice, 0)
            {
                RoutedEvent = Mouse.MouseLeaveEvent
            };

            MouseEventArgs mouseEnterArgs = new MouseEventArgs(Mouse.PrimaryDevice, 0)
            {
                RoutedEvent = Mouse.MouseEnterEvent
            };

            panelHamburger.RaiseEvent(mouseLeaveArgs);
            panelHamburger.RaiseEvent(mouseEnterArgs);
        }

        internal void SetHamburgerWidth(string cultureName)
        {
            Storyboard hamburgerOpen = this.TryFindResource("animationHamburgerOpen") as Storyboard;
            DoubleAnimation animation = hamburgerOpen.Children[0] as DoubleAnimation;
            animation.To = cultureName == "ru"
                ? Convert.ToDouble(this.TryFindResource("panelHamburgerRuMaxWidth"))
                : Convert.ToDouble(this.TryFindResource("panelHamburgerEnMaxWidth"));
        }

        private void ButtonHamburger_Click(object sender, MouseButtonEventArgs e)
        {            
            SetActivePanel(sender as HamburgerCategoryButton);
        }

        private void ButtonHamburgerLanguageSettings_Click(object sender, MouseButtonEventArgs e)
        {            
            Resources.MergedDictionaries.Add(ChangeCulture());
            SetHamburgerWidth(GetCurrentCultureName());
            HamburgerReOpen();
            textTogglesHeader.Text = Convert.ToString(Resources[LastClickedButtonName]);            
        }

        private void Window_Initialized(object sender, EventArgs e)
        {
            InitializeVariables();            
            SetUiLanguage();
            InitializeToggles();
            SetHamburgerWidth(GetCurrentCultureName());            
            SetActivePanel(HamburgerPrivacy);
        }        
    }
}
