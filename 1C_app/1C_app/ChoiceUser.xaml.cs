﻿using System;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Windows;
using static _1C_app.LoginApp;

namespace _1C_app
{
    /// <summary>
    /// Логика взаимодействия для ChoiceUser.xaml
    /// </summary>
    public partial class ChoiceUser : Window
    {
       
        string connectionString = "Server=(localdb)\\MSSQLLocalDB;Database=DSA;Trusted_Connection=True;";
        // string connectionString = "Server=.\\SQLEXPRESS;Database=DSA;Trusted_Connection=True;";
        public ChoiceUser()
        {
            InitializeComponent();
            try
            {
                ViewdannieTB();
            }
            catch
            {
                MessageBox.Show("Eroor");
            }
            Contact.Visibility = Visibility.Hidden;
            editing.Visibility = Visibility.Hidden;
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

                        Country_edit.Items.Add(fullName);
                    }
                    reader1.Close();
                }

            }
            connection.Close();
        }
        private void LoadComboBoxGender()
        {
            Gender_edit.Items.Add("Мужской");
            Gender_edit.Items.Add("Женщина");
        }
        private void ViewdannieTB()
        {

            string sqlQuery = $"SELECT [User].Email,[User].FirstName, [Gender].Gender, [User].LastName,[Runner].DateOfBirth, [Country].CountryName FROM [User] " +
                $"INNER JOIN [Runner]  ON [User].Email = Runner.Email " +
                $"INNER JOIN [Gender] on Runner.Gender = Gender.GenderId " +
                $"INNER JOIN [Country] on Runner.CountryCode = Country.CountryCode " +
                $"WHERE [User].Email = '{Global.Login}'";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand(sqlQuery, connection);
                try
                {
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();

                    if (reader.Read())
                    {
                        Email_check.Text = reader["Email"].ToString();
                        Name_edit.Text = reader["FirstName"].ToString();
                        FirstName_edit.Text = reader["LastName"].ToString();
                        Date_edit.Text = Convert.ToDateTime(reader["DateOfBirth"]).ToString("dd/MM/yyyy");
                        Gender_edit.SelectedItem = reader["Gender"].ToString();
                        Country_edit.SelectedItem = reader["CountryName"].ToString();
                    }

                    reader.Close();
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }
            }
        }
        private void editingInsertProfile()
        {
            bool NeedPass = false;
            if (string.IsNullOrEmpty(Password_edit.Text))
            {
                NeedPass = false;
            }
            else
            {
                NeedPass = true;
                if (!Regex.IsMatch(Password_edit.Text, "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$%^]).{6,}$"))
                {
                    throw new Exception("Введите коректно пароль");
                }
                else if (this.Password_edit.Text != Password_edit.Text)
                {

                    throw new Exception("Пароль не совпадает с указаным");
                }
            }
            string sqlQueryy = string.Empty;
            if (NeedPass == true)
            {
                sqlQueryy = "DECLARE @country INT ; " +
                "DECLARE @Emailll VARCHAR (50) = @Email; " +
                "SELECT @country = CountryCode FROM [Country] WHERE CountryName = @CountryName; " +
                "UPDATE [User] SET [Email] = @Email, [Password] = @Password, [FirstName] = @FirstName,[LastName] = @LastName,[RoleId] = N'R' WHERE [Email] = @Emailll; " +
                "UPDATE [Runner] SET [Email] = @Emailll,[Gender] = @Gender,[DateOfBirth] = @DateOfBirth, [CountryCode] = @country WHERE [Email] = @Emailll; ";
            }
            else
            {
                sqlQueryy = "DECLARE @country INT ; " +
                "DECLARE @Emailll VARCHAR (50) = @Email; " +
                "SELECT @country = CountryCode FROM [Country] WHERE CountryName = @CountryName; " +
                "UPDATE [User] SET [Email] = @Email, [FirstName] = @FirstName,[LastName] = @LastName,[RoleId] = N'R' WHERE [Email] = @Emailll; " +
                "UPDATE [Runner] SET [Email] = @Emailll,[Gender] = @Gender,[DateOfBirth] = @DateOfBirth, [CountryCode] = @country WHERE [Email] = @Emailll; ";
            }         
            using (SqlConnection connection = new SqlConnection(connectionString))
            {

                connection.Open();
                SqlCommand command = new SqlCommand(sqlQueryy, connection);
                if (NeedPass == true)
                {
                    command.Parameters.AddWithValue("@Password", HashPassword.HashPass(Password_edit.Text));
                }

                command.Parameters.AddWithValue("@Email", Email_check.Text.Trim());


                if (Name_edit.Text == "")
                {

                    throw new Exception("Заполните поле Имя");

                }

                else
                {

                    command.Parameters.AddWithValue("@FirstName", Name_edit.Text);
                }
                if (FirstName_edit.Text == "")
                {

                    throw new Exception("Заполните поле Фамилия");

                }
                else
                {

                    command.Parameters.AddWithValue("@LastName", FirstName_edit.Text);
                }

                if (Gender_edit.Text == "")
                {

                    throw new Exception("Выберете пол");

                }
                else
                {
                    if (Gender_edit.Text == "Мужской")
                    {
                        command.Parameters.AddWithValue("@Gender", 1);
                    }
                    else
                    {
                        command.Parameters.AddWithValue("@Gender", 2);
                    }
                }
                if (Date_edit.Text == "")
                {

                    throw new Exception("Заполните поле даты рождения");
                }
                else
                {
                    if (dateFormat.IsValidAge(Date_edit.Text, 10))
                    {

                        command.Parameters.AddWithValue("@DateOfBirth", Date_edit.Text);
                    }
                    else
                    {

                        throw new Exception("Возраст не может быть меньше 10 лет");
                    }
                }

                if (Country_edit.Text == "")
                {
                    throw new Exception("Выберете страну");

                }
                else
                {
                    command.Parameters.AddWithValue("@CountryName", Country_edit.Text.Trim());
                }
               

                int number = command.ExecuteNonQuery();
                MessageBox.Show($"Данные успешно изменены :{number - 1}");


            }
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

        private void Clouse_Window(object sender, RoutedEventArgs e)
        {
            this.Close();
        }


        private void BattonClouse(object sender, RoutedEventArgs e)
        {
            Contact.Visibility = System.Windows.Visibility.Hidden;
        }

        private void ShowContacts(object sender, RoutedEventArgs e)
        {
            Contact.Visibility = System.Windows.Visibility.Visible;
        }

        private void Button_CancelProfile_Click(object sender, RoutedEventArgs e)
        {
            editing.Visibility = System.Windows.Visibility.Hidden;
            MenuRunnera.Visibility = System.Windows.Visibility.Visible;
        }

        private void Button_SaveProfile_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                editingInsertProfile();
            }
            catch (Exception ex)
            {
                Errorka.Text = ex.Message;
            }
        }



        private void ButtonEditProfile(object sender, RoutedEventArgs e)
        {
            editing.Visibility = System.Windows.Visibility.Visible;
            MenuRunnera.Visibility = System.Windows.Visibility.Hidden;
        }

        private void Button_ExitMenuRunner(object sender, RoutedEventArgs e)
        {
            editing.Visibility = System.Windows.Visibility.Hidden;
            MenuRunnera.Visibility = System.Windows.Visibility.Visible;
        }
    }
}
