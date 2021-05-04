#' World Risk Poll data
#'
#' A dataset containing individual-level survey data from the World Risk Poll.
#'
#' @format A data frame with variables:
#'
#' \describe{
#'
#' \item{wpidRandom}{Random Unique Case ID}
#' \item{country}{Respondent's country of residence}
#' \item{iso3C}{The iso three letter code for the respondent's country of residence}
#' \item{year}{Year of survey}
#' \item{globalRegion}{Global region respondent lives in}
#' \item{countryIncomeLevel}{World Bank Income classification of country}
#' \item{wgt}{Weight}
#' \item{projectionWeight}{Weight to be used for multi-country analysis}
#' \item{age}{Age}
#' \item{gender}{Gender}
#' \item{education}{Education Level}
#' \item{incomeFeelings}{Feelings About Household Income}
#' \item{income5}{Per Capita Income Quintiles}
#' \item{urbanicity}{Urban/Rural}
#' \item{householdSize}{Total number of people in household}
#' \item{childrenInHousehold}{Children under 15 in the household}
#' \item{l1}{When you hear the word RISK, do you think more about opportunity or danger?}
#' \item{l2}{Overall, compared to five years ago, do you feel more safe, less safe, or about as safe as you did five years ago?}
#' \item{l3A}{In your own words, what is the greatest source of RISK TO YOUR SAFETY in your daily life?}
#' \item{l3B}{Other than what you just mentioned in your own words what is another MAJOR source of RISK TO YOUR SAFETY in your daily life}
#' \item{l4A}{Please tell me whether you think each of the following will mostly HELP or mostly HARM people in this country in the next 20 years. Genetically-modified food}
#' \item{l4B}{The use of nuclear power for electricity}
#' \item{l4C}{Machines or robots that can think and make decisions, often known as artificial intelligence}
#' \item{l5}{Do you think that climate change is a very serious threat, a somewhat serious threat, or not a threat at all to the people in this country in the next 20 years? If you do not know, please just say so}
#' \item{l6A}{In general, how WORRIED are you that each of the following things could cause you serious harm? Are you very worried, somewhat worried, or not worried? The food you eat}
#' \item{l6B}{The water you drink}
#' \item{l6C}{Violent crime}
#' \item{l6D}{Severe weather events, such as floods or violent storms}
#' \item{l6E}{Electrical power lines}
#' \item{l6F}{Household appliances, such as a washing machine, dryer, or refrigerator}
#' \item{l6G}{Mental health issues}
#' \item{l7A}{How LIKELY do you think it is that each of the following things COULD cause you serious harm in the next TWO years? The food you eat}
#' \item{l7B}{The water you drink}
#' \item{l7C}{Violent crime}
#' \item{l7D}{Severe weather events, such as floods or violent storms}
#' \item{l7E}{Electrical power lines}
#' \item{l7F}{Household appliances, such as a washing machine, dryer, or refrigerator}
#' \item{l7G}{Mental health issues}
#' \item{l8A}{Have you or someone you PERSONALLY know, EXPERIENCED serious harm from any of the following things in the past TWO years? Eating food}
#' \item{l8B}{Drinking water}
#' \item{l8C}{Violent crime}
#' \item{l8D}{Severe weather events, such as floods or violent storms}
#' \item{l8E}{Electrical power lines}
#' \item{l8F}{Household appliances, such as a washing machine, dryer, or refrigerator}
#' \item{l8G}{Mental health issues}
#' \item{l9A}{Being in a traffic accident}
#' \item{l9B}{Being physically attacked by someone}
#' \item{l9C}{Being in an airplane accident}
#' \item{l9D}{Drowning}
#' \item{l9E}{Being struck by lightning}
#' \item{l10}{In general, do you wear a seatbelt if you are in a motorized vehicle and one is available?}
#' \item{l11}{Are you able to swim without any assistance at all?}
#' \item{l12}{Do you think that 10% is bigger than 1 out of 10, smaller than 1 out of 10, or the same as 1 out of 10? If you do not know, please just say so.}
#' \item{l13A}{Suppose you wanted to find out if the food you eat is safe. Would you look to any of the following sources for information, or not? Friends or family}
#' \item{l13B}{Medical professionals, such as your local doctor or nurse}
#' \item{l13C}{Newspapers, television or radio}
#' \item{l13D}{The Internet/social media}
#' \item{l13E}{INSERT government agency responsible for providing food safety information}
#' \item{l13F}{The packaging or label on the food}
#' \item{l13G}{A famous person you like}
#' \item{l13H}{Local religious leaders}
#' \item{l14}{Considering the sources of information you would access, which one would you trust MOST to provide information about food safety?}
#' \item{l15}{In general, do you think the government should require businesses to adopt safety procedures and rules, or not?}
#' \item{l16A}{In general, in your opinion does the government do a good job ensuring that the following are safe, or not? The food you buy}
#' \item{l16B}{The water you drink}
#' \item{l16C}{Powerlines in the city or area where you live}
#' \item{l17A}{Suppose you lost a small bag that contained items of great financial value to you that had your name and address written on it. If it were found by each of the following people, in general, how likely is it that it would be returned to you with all of its contents? A neighbour}
#' \item{l17B}{A stranger}
#' \item{l17C}{The police}
#' \item{l18}{How likely do you think it is that you could be injured while working in the next TWO years?}
#' \item{l19}{Have you EVER been seriously injured while working?}
#' \item{l20A}{Are any of the following a source of risk to your personal safety WHILE YOU ARE WORKING? Operating equipment or heavy machinery}
#' \item{l20B}{Fire}
#' \item{l20C}{Exposure to chemicals or biological substances}
#' \item{l20D}{Physical harassment or violence}
#' \item{l20E}{Tripping or falling}
#' \item{l21A}{Have you or has anyone you work with experienced injury or harm from any of the following WHILE WORKING in the past TWO years? Operating equipment or heavy machinery}
#' \item{l21B}{Fire}
#' \item{l21C}{Exposure to chemicals or biological substances}
#' \item{l21D}{Physical harassment or violence}
#' \item{l21E}{Tripping or falling}
#' \item{l22}{Do you agree or disagree with the following statement? You are free to report any safety problems you notice to your employer without fear of punishment}
#' \item{l23}{Other than yourself, who do you feel is MOST responsible for your safety while you are working?}
#' \item{l24A}{Do you think each of the following CARE about your safety while you are working, yes or no? If the person or group does not apply to you, please say so. Your co-workers}
#' \item{l24B}{Your boss or supervisor}
#' \item{l24C}{The trade or labour union}
#' \item{l25}{Do you think the safety rules at your place of work are a good thing to have or do they make your job more difficult to do?}
#' \item{l26}{Have you used the Internet, including social media, in the past 30 days?}
#' \item{l27A}{When using the Internet or social media, do you worry about any of the following things happening to you? Online bullying, such as someone sending you a hateful message or comment through social media}
#' \item{l27B}{Receiving false information, such as news or information which is not true}
#' \item{l27C}{Fraud, such as someone stealing your bank information or your money}
#'
#' }
#'
#' @source \url{https://wrp.lrfoundation.org.uk/}

"wrp"
