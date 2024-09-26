using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
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
    /// Логика взаимодействия для RegistrationUser.xaml
    /// </summary>
    public partial class RegistrationUser : Window
    {
        string connectionString = "Server=(localdb)\\MSSQLLocalDB;Database=DSA;Trusted_Connection=True;";
        public RegistrationUser()
        {
            InitializeComponent();
            LoadComboBoxData();
            LoadComboBoxGender();
        }
        private void LoadComboBoxData()
        {

            SqlConnection connection = new SqlConnection(connectionString);
            connection.Open();

            if (connection.State == ConnectionState.Open)
            {
                string sqlExpression1 = $"select CountryName from Country";
                SqlCommand command1 = new SqlCommand(sqlExpression1, connection);
                SqlDataReader reader1 = command1.ExecuteReader();
                if (reader1.HasRows)
                {
                    while (reader1.Read())
                    {
                        string fullName = $"{reader1.GetString(0)}";

                        Country_add_ComboBox.Items.Add(fullName);
                    }
                    reader1.Close();
                }

            }
            connection.Close();
        }
        private void LoadComboBoxGender()
        {

            Gender_add_ComboBox.ItemsSource = new List<string> { "Мужской", "Женский" };
        }
        private void RegistrRunner()
        {
            bool check = false;
            string sqlQueryy = "DECLARE @Emailll VARCHAR (50) = @Email;" +
                "Declare @country int = (Select [Country].CountryCode from Country where [Country].CountryName = @CountryName);" +
                "INSERT INTO [User] ([Email], [Password], [FirstName], [LastName], [RoleId]) VALUES (@Emailll,@Password,@FirstName,@LastName,N'R')" +
                "INSERT INTO [Runner] ([RunnerId], [Email], [Gender], [DateOfBirth], [CountryCode]) VALUES ((SELECT ISNULL(MAX(RunnerId), 0) + 1 FROM [Runner]),@Emailll, @Gender, @DateOfBirth,@country)";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                
                try
                {
                    connection.Open();
                    SqlCommand command = new SqlCommand(sqlQueryy, connection);

                    if (Email_add.Text == "" && !check)
                    {
                        MessageBox.Show("Поле Email ");
                        check = true;
                    }
                    else
                    {
                        command.Parameters.AddWithValue("@Email", Email_add.Text);
                    }
                    if ((Password_add.Text == "" && rPassword_add.Text == "")&& !check)
                    {
                        MessageBox.Show("Поле Пароль не должно быть пустым");
                        check = true;
                    }
                    else if (this.Password_add.Text != rPassword_add.Text)
                    {

                        MessageBox.Show("Пароль не совпадает с указаным");
                    }
                    else
                    {
                        command.Parameters.AddWithValue("@Password", Password_add.Text);
                        
                    }
                    if (FirstName_add.Text == "" && !check)
                    {
                        MessageBox.Show("Поле Email");
                        check = true;
                    }
                    else
                    {
                        command.Parameters.AddWithValue("@FirstName", FirstName_add.Text);
                    }
                    if (LastName_add.Text == "" && !check)
                    {
                        MessageBox.Show("Поле Email");
                        check = true;
                    }
                    else
                    {
                        command.Parameters.AddWithValue("@LastName", FirstName_add.Text);
                    }

                    if (Gender_add_ComboBox.Text == "" && !check)
                    { 
                        
                        MessageBox.Show("Поле Email");
                        check = true;
                    }
                    else
                    {
                        if (Gender_add_ComboBox.Text == "Мужской")
                        {
                            command.Parameters.AddWithValue("@Gender", 1);
                        }
                        else
                        {
                            command.Parameters.AddWithValue("@Gender", 2);
                        }
                    }
                    if (Birthday_add.Text == "" && !check)
                    {
                        MessageBox.Show("Поле Email");
                        check = true;
                    }
                    else
                    {
                        command.Parameters.AddWithValue("@DateOfBirth", Birthday_add.Text);
                    }
                    if (Country_add_ComboBox.Text == "" && !check)
                    {
                        MessageBox.Show("Поле Email");
                        check = true;
                    }
                    else
                    {
                        command.Parameters.AddWithValue("@CountryName", Country_add_ComboBox.Text.Trim());
                    }




                    int number = command.ExecuteNonQuery();
                    MessageBox.Show($"Учетная запись создана:{number - 1}");

                    MainWindow RegistrationUser = new MainWindow();
                    this.Close();
                    RegistrationUser.ShowDialog();
                }
                catch (SqlException ex)
                {
                    MessageBox.Show("Ошибка при изменении данных: " + ex.Message);
                }
               
            }
        }
       
        private void BackMenu()
        {
            MainWindow RegistrationUser = new MainWindow();
            this.Close();
            RegistrationUser.ShowDialog();
        }
        private void Button_Exit_Click(object sender, RoutedEventArgs e)
        {
            BackMenu();   
        }

        private void TextBox_TextChanged(object sender, TextChangedEventArgs e)
        {

        }

        private void Button_registr_Click(object sender, RoutedEventArgs e)
        {
            RegistrRunner();
        }

        private void Button_Otmena_Click(object sender, RoutedEventArgs e)
        {
            BackMenu();
        }

        private void Clouse_Window(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
    }
}
