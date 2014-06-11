
library(shiny)

activity.text <- c('Little to no exercise'
                   ,'Light exercise (1–3 days per week)'
                   ,'Moderate exercise (3–5 days per week)'
                   ,'Heavy exercise (6–7 days per week)'
                   ,'Very heavy exercise (twice per day)'
                  )

# Constants used to calculate the basal metabolic rate (BMR)
male.constant <- 88.362
male.weight.multiplier <- 13.397
male.height.multiplier <- 4.799
male.age.multiplier <- 5.677

female.constant <- 447.593
female.weight.multiplier <- 9.247
female.height.multiplier <- 3.098
female.age.multiplier <- 4.330

activity.multiplier <- c(1.2, 1.375, 1.55, 1.725, 1.9)


# Function to calculate a person'r BMR
bmr <- function(gender, height, age, weight) {
  # If gender is male use male constants
  constant <- male.constant
  weight.multiplier <- male.weight.multiplier
  height.multiplier <- male.height.multiplier
  age.multiplier <- male.age.multiplier

  # If gender is female use female constants
  if (gender == 'f') {
    constant <- female.constant
    weight.multiplier <- female.weight.multiplier
    height.multiplier <- female.height.multiplier
    age.multiplier <- female.age.multiplier
  }

  # Calculate BMR
  result <- constant + (weight.multiplier * weight) + (height.multiplier *
    height) - (age.multiplier * age)

  return(result)
}

# Applies the Harris-Benedict principle
hb.principle <- function(bmr, activity.level) {
  result <- bmr * activity.multiplier[activity.level]
  return(result)
}

# Calculates an individual's recommended daily calorie intake to maintain
# weight
daily.kilocalories <- function(gender, height, age, weight, activity.level) {
  rate <- bmr(gender, height, age, weight)
  calories <- hb.principle(rate, activity.level)

  return(calories)
}


# Server implementation
shinyServer(
  function(input, output) {
    # Input confirmation display
    output$gender <- renderPrint({if (input$gender == 'm') 'Male' else 'Female'})
    output$height <- renderPrint({input$height})
    output$age <- renderPrint({input$age})
    output$weight <- renderPrint({input$weight})
    output$activity <- renderPrint({activity.text[as.numeric(input$activity)]})

    # Data output
    output$calorie <-renderPrint({
      daily.kilocalories(input$gender, input$height, input$age, input$weight,
                         as.numeric(input$activity))
    })
  }
)


