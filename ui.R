
library(shiny)

shinyUI(fluidPage(
  titlePanel('Wanna lose weight?')
  ,h3('Daily Calorie Consumption Calculator')

  ,sidebarLayout(
    sidebarPanel(
      # Input
      h3('Data Input')
      # Gender
      ,radioButtons('gender', 'Gender', c('Male' = 'm', 'Female' = 'f'))
      # Height
      ,numericInput('height', 'Height (cm)', 180, min = 0, max = 400, step = 1)
      # Age
      ,numericInput('age', 'Age', 30, min = 0, max = 300, step = 1)
      # Weight
      ,numericInput('weight', 'Weight (kg)', 70, min = 0, max = 300, step = 1)
      # Physical Activity
      ,radioButtons('activity', 'Level of physical activity',
                          c('Little to no exercise' = 1
                            ,'Light exercise (1–3 days per week)' = 2
                            ,'Moderate exercise (3–5 days per week)' = 3
                            ,'Heavy exercise (6–7 days per week)' = 4
                            ,'Very heavy exercise (twice per day)' = 5
                           )
                   )
    )

    ,mainPanel(
      # Input confirmation display
      h3('Your input')
      # Gender
      ,p('Gender')
      ,verbatimTextOutput('gender')
      # Height
      ,p('Height (cm)')
      ,verbatimTextOutput('height')
      # Age
      ,p('Age')
      ,verbatimTextOutput('age')
      # Weight
      ,p('Weight (kg)')
      ,verbatimTextOutput('weight')
      # Level of physical activity
      ,p('Level of physical activity')
      ,verbatimTextOutput('activity')

      # Data output
      ,h3('Output')
      ,p('Daily kilocalories needed to maintain weight')
      ,p('Consume less than this everyday and you will lose weight in no time.')
      ,verbatimTextOutput('calorie')
    )
  )
))

