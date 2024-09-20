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
    /// Логика взаимодействия для ChoiceUser.xaml
    /// </summary>
    public partial class ChoiceUser : Window
    {
        public ChoiceUser()
        {
            InitializeComponent();
        }

        private void Button_Loguot_Click(object sender, RoutedEventArgs e)
        {
            MainWindow ChoiceUser = new MainWindow();
            this.Close();
            ChoiceUser.ShowDialog();
        }

        private void Button_Exit_Click(object sender, RoutedEventArgs e)
        {
            MainWindow ChoiceUser = new MainWindow();
            this.Close();
            ChoiceUser.ShowDialog();
        }
    }
}
