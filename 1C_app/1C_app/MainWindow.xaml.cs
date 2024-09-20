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
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace _1C_app
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
            DiscoverEvent.Visibility = Visibility.Hidden;
            RunnerGrid.Visibility = Visibility.Hidden;
            BecomeSponsor.Visibility = Visibility.Hidden;
        }

        private void Button_Logint_Click(object sender, RoutedEventArgs e)
        {
            LoginApp mainWindow = new LoginApp();
            this.Close();
            mainWindow.ShowDialog();
        }

        private void Button_Runner_Click(object sender, RoutedEventArgs e)
        {

            GlavniyGrid.Visibility = System.Windows.Visibility.Hidden;
            ButtonGrid.Visibility = System.Windows.Visibility.Hidden;
            RunnerGrid.Visibility = System.Windows.Visibility.Visible;
            LoginGrid.Visibility = System.Windows.Visibility.Visible;
        }

        private void Button_Exit_Click(object sender, RoutedEventArgs e)
        {
            GlavniyGrid.Visibility = System.Windows.Visibility.Visible;
            ButtonGrid.Visibility = System.Windows.Visibility.Visible;
            RunnerGrid.Visibility = System.Windows.Visibility.Hidden;
            LoginGrid.Visibility = System.Windows.Visibility.Visible;
        }

        private void Bil_Runnerom_Click(object sender, RoutedEventArgs e)
        {
            LoginApp mainWindow = new LoginApp();
            this.Close();
            mainWindow.ShowDialog();
        }

        private void Button_learnEvent_Click(object sender, RoutedEventArgs e)
        {
            GlavniyGrid.Visibility = System.Windows.Visibility.Hidden;
            ButtonGrid.Visibility = System.Windows.Visibility.Hidden;
            LoginGrid.Visibility = System.Windows.Visibility.Hidden;
            DiscoverEvent.Visibility = System.Windows.Visibility.Visible;


        }

        private void ExitMain_Button_Click(object sender, RoutedEventArgs e)
        {
            GlavniyGrid.Visibility = System.Windows.Visibility.Visible;
            ButtonGrid.Visibility = System.Windows.Visibility.Visible;
            LoginGrid.Visibility = System.Windows.Visibility.Visible;
            DiscoverEvent.Visibility = System.Windows.Visibility.Hidden;
        }

        private void Button_SponserRunner_Click(object sender, RoutedEventArgs e)
        {
            GlavniyGrid.Visibility = System.Windows.Visibility.Hidden;
            ButtonGrid.Visibility = System.Windows.Visibility.Hidden;
            LoginGrid.Visibility = System.Windows.Visibility.Hidden;
            BecomeSponsor.Visibility = System.Windows.Visibility.Visible;
        }

        private void Button_Pay_Click(object sender, RoutedEventArgs e)
        {

        }

        private void Button_Сеncel_Click(object sender, RoutedEventArgs e)
        {

        }

        private void Button_Minus_Click(object sender, RoutedEventArgs e)
        {

        }

        private void Button_Plus_Click(object sender, RoutedEventArgs e)
        {

        }

        private void Button_Cenceled_Click(object sender, RoutedEventArgs e)
        {
            GlavniyGrid.Visibility = System.Windows.Visibility.Visible;
            ButtonGrid.Visibility = System.Windows.Visibility.Visible;
            LoginGrid.Visibility = System.Windows.Visibility.Visible;
            BecomeSponsor.Visibility = System.Windows.Visibility.Hidden;
        }

        private void Nebil_Runnerom_Click(object sender, RoutedEventArgs e)
        {
            RegistrationUser MainWindow = new RegistrationUser();
            this.Close();
            MainWindow.ShowDialog();
        }
    }
}
