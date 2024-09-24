using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace _1C_app
{
    /// <summary>
    /// Логика взаимодействия для MenuAdministratora.xaml
    /// </summary>
    public partial class MenuAdministratora : Window
    {
        public MenuAdministratora()
        {
            InitializeComponent();
        }
        private void ExitMenu ()
        {
            MainWindow MenuAdministratora = new MainWindow();
            this.Close();
            MenuAdministratora.ShowDialog();

        }

        private void Button_Exit_Click(object sender, RoutedEventArgs e)
        {
            ExitMenu();

        }

        private void Button_Loguot_Click(object sender, RoutedEventArgs e)
        {
            ExitMenu();
        }

        private void Clouse_Window(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
    }
}
