### CDC DATA VIEWER APP ###

## Load Required Packages ##
if (!require("tidyverse")) install.packages('tidyverse')
library("tidyverse")
if (!require("naniar")) install.packages('naniar')
library("naniar")
if (!require("shiny")) install.packages('shiny')
library("shiny")
if (!require("shinydashboard")) install.packages('shinydashboard')
library("shinydashboard")

options(scipen = 999)

## Load CDC Data ## 
cdc <- readr::read_csv("data/cdc.csv", col_types = cols(X1 = col_skip()))

cdc$race <- as.factor(cdc$race)
cdc$cause_of_death <- as.factor(cdc$cause_of_death)


ui <- dashboardPage(
  dashboardHeader(title = "CDC Data Viewer"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Home", tabName = "home", icon = icon("home")),
      menuItem("Cause of Death by Year", tabName = "app1", icon = icon("calendar-alt")),
      menuItem("Age Group Mortality", tabName = "app2", icon = icon("feather")),
      menuItem("Cause of Death by Race", tabName="app3", icon=icon("address-book")),
      menuItem("Cause of Death by Gender", tabName="app4", icon=icon("venus-mars"))
      
      
      
      )),
  dashboardBody(
    tags$head(tags$style(HTML('
        .skin-blue .main-header .navbar {
                              background-color: #355B85;
        }
        .skin-blue .main-header .logo {
                              background-color: #002855;
                              }
                              '))),
    tabItems(
      tabItem(tabName = "home",
              fluidRow(
                box(width=12,
                  HTML(
                    paste(
                      h3("Welcome to the CDC Data Visualizer"),
                      h4("By Lia Freed-Doerr and Dawson Diaz"),
                      h4("for BIS15L with Dr. Joel Ledford"), '<br/>',
                      img(src="https://ih1.redbubble.net/image.543360227.2115/flat,750x1000,075,f.u1.jpg", height=250, width=200),
                      img(src="https://biology.ucdavis.edu/sites/g/files/dgvnsk2646/files/styles/sf_profile/public/images/person/LedfordJoel14558.jpg", width=210, height=240),
                      img(src="https://www.cdc.gov/TemplatePackage/contrib/widgets/images/cdc_badge.png"),

                      h3("Explore the Sidebar for Various Visualizations!")
                    ))
                ))),
      
      
      tabItem(tabName = "app1",
              
              
              fluidRow(
                box(title = "Select Cause of Death", width = 12,
                    selectInput("app1_cause_of_death", "ICD 113 Causes of Death", choices = c("Accidents (unintentional injuries) (V01-X59,Y85-Y86)",
                                                                                              "Acute bronchitis and bronchiolitis (J20-J21)",
                                                                                              "Acute poliomyelitis (A80)",
                                                                                              "Alzheimer disease (G30)",
                                                                                              "Anemias (D50-D64)",
                                                                                              "Aortic aneurysm and dissection (I71)",
                                                                                              "Arthropod-borne viral encephalitis (A83-A84,A85.2)",
                                                                                              "Assault (homicide) (*U01-*U02,X85-Y09,Y87.1)",
                                                                                              "Atherosclerosis (I70)",
                                                                                              "Cerebrovascular diseases (I60-I69)",
                                                                                              "Certain conditions originating in the perinatal period (P00-P96)",
                                                                                              "Cholelithiasis and other disorders of gallbladder (K80-K82)",
                                                                                              "Chronic liver disease and cirrhosis (K70,K73-K74)",
                                                                                              "Chronic lower respiratory diseases (J40-J47)",
                                                                                              "Complications of medical and surgical care (Y40-Y84,Y88)",
                                                                                              "Congenital malformations, deformations and chromosomal abnormalities (Q00-Q99)",
                                                                                              "Diabetes mellitus (E10-E14)",
                                                                                              "Diseases of appendix (K35-K38)",
                                                                                              "Diseases of heart (I00-I09,I11,I13,I20-I51)",
                                                                                              "Enterocolitis due to Clostridium difficile (A04.7)",
                                                                                              "Essential hypertension and hypertensive renal disease (I10,I12,I15)",
                                                                                              "Hernia (K40-K46)",
                                                                                              "Human immunodeficiency virus (HIV) disease (B20-B24)",
                                                                                              "Hyperplasia of prostate (N40)",
                                                                                              "In situ neoplasms, benign neoplasms and neoplasms of uncertain or unknown behavior (D00-D48)",
                                                                                              "Infections of kidney (N10-N12,N13.6,N15.1)",
                                                                                              "Inflammatory diseases of female pelvic organs (N70-N76)",
                                                                                              "Influenza and pneumonia (J09-J18)",
                                                                                              "Intentional self-harm (suicide) (*U03,X60-X84,Y87.0)",
                                                                                              "Legal intervention (Y35,Y89.0)",
                                                                                              "Malaria (B50-B54)",
                                                                                              "Malignant neoplasms (C00-C97)",
                                                                                              "Measles (B05)",
                                                                                              "Meningitis (G00,G03)",
                                                                                              "Meningococcal infection (A39)",
                                                                                              "Nephritis, nephrotic syndrome and nephrosis (N00-N07,N17-N19,N25-N27)",
                                                                                              "Nutritional deficiencies (E40-E64)",
                                                                                              "Operations of war and their sequelae (Y36,Y89.1)",
                                                                                              "Parkinson disease (G20-G21)",
                                                                                              "Peptic ulcer (K25-K28)",
                                                                                              "Pneumoconioses and chemical effects (J60-J66,J68)",
                                                                                              "Pneumonitis due to solids and liquids (J69)",
                                                                                              "Pregnancy, childbirth and the puerperium (O00-O99)",
                                                                                              "Salmonella infections (A01-A02)",
                                                                                              "Scarlet fever and erysipelas (A38,A46)",
                                                                                              "Septicemia (A40-A41)",
                                                                                              "Shigellosis and amebiasis (A03,A06)",
                                                                                              "Syphilis (A50-A53)",
                                                                                              "Tuberculosis (A16-A19)",
                                                                                              "Viral hepatitis (B15-B19)",
                                                                                              "Whooping cough (A37)",
                                                                                              "Accidental discharge of firearms (W32-W34)",
                                                                                              "Accidental drowning and submersion (W65-W74)",
                                                                                              "Accidental exposure to smoke, fire and flames (X00-X09)",
                                                                                              "Accidental poisoning and exposure to noxious substances (X40-X49)",
                                                                                              "Acute and rapidly progressive nephritic and nephrotic syndrome (N00-N01,N04)",
                                                                                              "Acute and subacute endocarditis (I33)",
                                                                                              "Acute myocardial infarction (I21-I22)",
                                                                                              "Acute rheumatic fever and chronic rheumatic heart diseases (I00-I09)",
                                                                                              "Alcoholic liver disease (K70)",
                                                                                              "All other and unspecified malignant neoplasms (C17,C23-C24,C26-C31,C37-C41,C44-C49,C51-C52,C57-C60,C62-C63,C66,C68-C69,C73-C80,C97)",
                                                                                              "All other diseases (Residual)",
                                                                                              "All other forms of chronic ischemic heart disease (I20,I25.1-I25.9)",
                                                                                              "All other forms of heart disease (I26-I28,I34-I38,I42-I49,I51)",
                                                                                              "Assault (homicide) by discharge of firearms (*U01.4,X93-X95)",
                                                                                              "Assault (homicide) by other and unspecified means and their sequelae (*U01.0-*U01.3,*U01.5-*U01.9,*U02,X85-X92,X96-Y09,Y87.1)",
                                                                                              "Asthma (J45-J46)",
                                                                                              "Atherosclerotic cardiovascular disease, so described (I25.0)",
                                                                                              "Bronchitis, chronic and unspecified (J40-J42)",
                                                                                              "Certain other intestinal infections (A04,A07-A09)",
                                                                                              "Chronic glomerulonephritis, nephritis and nephropathy not specified as acute or chronic, and renal sclerosis unspecified (N02-N03,N05-N07,N26)",
                                                                                              "Discharge of firearms, undetermined intent (Y22-Y24)",
                                                                                              "Diseases of pericardium and acute myocarditis (I30-I31,I40)",
                                                                                              "Emphysema (J43)",
                                                                                              "Events of undetermined intent (Y10-Y34,Y87.2,Y89.9)",
                                                                                              "Falls (W00-W19)",
                                                                                              "Heart failure (I50)",
                                                                                              "Hodgkin disease (C81)",
                                                                                              "Hypertensive heart and renal disease (I13)",
                                                                                              "Hypertensive heart disease (I11)",
                                                                                              "Influenza (J09-J11)",
                                                                                              "Intentional self-harm (suicide) by discharge of firearms (X72-X74)",
                                                                                              "Intentional self-harm (suicide) by other and unspecified means and their sequelae (*U03,X60-X71,X75-X84,Y87.0)",
                                                                                              "Ischemic heart diseases (I20-I25)",
                                                                                              "Leukemia (C91-C95)",
                                                                                              "Major cardiovascular diseases (I00-I78)",
                                                                                              "Malignant melanoma of skin (C43)",
                                                                                              "Malignant neoplasm of bladder (C67)",
                                                                                              "Malignant neoplasm of breast (C50)",
                                                                                              "Malignant neoplasm of cervix uteri (C53)",
                                                                                              "Malignant neoplasm of esophagus (C15)",
                                                                                              "Malignant neoplasm of larynx (C32)",
                                                                                              "Malignant neoplasm of ovary (C56)",
                                                                                              "Malignant neoplasm of pancreas (C25)",
                                                                                              "Malignant neoplasm of prostate (C61)",
                                                                                              "Malignant neoplasm of stomach (C16)",
                                                                                              "Malignant neoplasms of colon, rectum and anus (C18-C21)",
                                                                                              "Malignant neoplasms of corpus uteri and uterus, part unspecified (C54-C55)",
                                                                                              "Malignant neoplasms of kidney and renal pelvis (C64-C65)",
                                                                                              "Malignant neoplasms of lip, oral cavity and pharynx (C00-C14)",
                                                                                              "Malignant neoplasms of liver and intrahepatic bile ducts (C22)",
                                                                                              "Malignant neoplasms of lymphoid, hematopoietic and related tissue (C81-C96)",
                                                                                              "Malignant neoplasms of meninges, brain and other parts of central nervous system (C70-C72)",
                                                                                              "Malignant neoplasms of trachea, bronchus and lung (C33-C34)",
                                                                                              "Malnutrition (E40-E46)",
                                                                                              "Motor vehicle accidents (V02-V04,V09.0,V09.2,V12-V14,V19.0-V19.2,V19.4-V19.6,V20-V79,V80.3-V80.5,V81.0-V81.1,V82.0-V82.1,V83-V86,V87.0-V87.8,V88.0-V88.8,V89.0,V89.2)",
                                                                                              "Multiple myeloma and immunoproliferative neoplasms (C88,C90)",
                                                                                              "Non-Hodgkin lymphoma (C82-C85)",
                                                                                              "Nontransport accidents (W00-X59,Y86)",
                                                                                              "Other acute ischemic heart diseases (I24)",
                                                                                              "Other acute lower respiratory infections (J20-J22,U04)",
                                                                                              "Other and unspecified acute lower respiratory infections (J22,U04)",
                                                                                              "Other and unspecified events of undetermined intent and their sequelae (Y10-Y21,Y25-Y34,Y87.2,Y89.9)",
                                                                                              "Other and unspecified infectious and parasitic diseases and their sequelae (A00,A05,A20-A36,A42-A44,A48-A49,A54-A79,A81-A82,A85.0-A85.1,A85.8,A86-B04,B06-B09,B25-B49,B55-B99)",
                                                                                              "Other and unspecified malignant neoplasms of lymphoid, hematopoietic and related tissue (C96)",
                                                                                              "Other and unspecified nontransport accidents and their sequelae (W20-W31,W35-W64,W75-W99,X10-X39,X50-X59,Y86)",
                                                                                              "Other chronic liver disease and cirrhosis (K73-K74)",
                                                                                              "Other chronic lower respiratory diseases (J44,J47)",
                                                                                              "Other complications of pregnancy, childbirth and the puerperium (O10-O99)",
                                                                                              "Other diseases of arteries, arterioles and capillaries (I72-I78)",
                                                                                              "Other diseases of circulatory system (I71-I78)",
                                                                                              "Other diseases of respiratory system (J00-J06,J30- J39,J67,J70-J98)",
                                                                                              "Other disorders of circulatory system (I80-I99)",
                                                                                              "Other disorders of kidney (N25,N27)",
                                                                                              "Other forms of chronic ischemic heart disease (I20,I25)",
                                                                                              "Other heart diseases (I26-I51)",
                                                                                              "Other land transport accidents (V01,V05-V06,V09.1,V09.3-V09.9,V10-V11,V15-V18,V19.3,V19.8-V19.9,V80.0-V80.2,V80.6-V80.9,V81.2-V81.9,V82.2-V82.9,V87.9,V88.9,V89.1,V89.3,V89.9)",
                                                                                              "Other nutritional deficiencies (E50-E64)",
                                                                                              "Other tuberculosis (A17-A19)",
                                                                                              "Pneumonia (J12-J18)",
                                                                                              "Pregnancy with abortive outcome (O00-O07)",
                                                                                              "Renal failure (N17-N19)",
                                                                                              "Respiratory tuberculosis (A16)",
                                                                                              "Symptoms, signs and abnormal clinical and laboratory findings, not elsewhere classified (R00-R99)",
                                                                                              "Transport accidents (V01-V99,Y85)",
                                                                                              "Water, air and space, and other and unspecified transport accidents and their sequelae (V90-V99,Y85)")
                                , selected = "Accidents (unintentional injuries) (V01-X59,Y85-Y86)"),
                )
              ),
              
              fluidRow(
                box(width = 12,
                    plotOutput("app1", width = "800px", height = "500px")
                    
                )),
              
              
              fluidRow(
                box(title = "Total Deaths by Selected Cause by Year", width = 6,
                    tableOutput("app1total")
                ),
                box(title = "Male vs. Female Deaths by Selected Cause", width = 3,
                    tableOutput("app1totalmf")
                ),
                box(title = "1999-2018 Total Deaths by Selected Cause", width = 3,
                    tableOutput("app1totalyr")
                )
                
              ),
              
              
              
      ),
      tabItem(tabName= "app2",
              fluidRow(
                box(title = "Graph Options", width = 12,
                    selectInput("app2_measure", "Mortality Measure", choices = c("death_per_100k", "total_deaths", "percent_of_group"), selected="death_per_100k"),
                    selectInput("app2_year", "Year", choices=c("1999","2000","2001","2002","2003","2004","2005","2006","2007","2008","2009","2010","2011","2012","2013","2014","2015","2016","2017","2018"), selected="2018"))),
              
              fluidRow(
                box(width = 12,
                    plotOutput("app2", width = "800px", height = "500px")))
              
      ),
      
      
      tabItem(tabName= "app3",
              fluidRow(
                box(title = "Cause of Death Options", width = 12,
                    selectInput("app3_death", "Select Cause of Death", choices = c(levels(cdc$cause_of_death)),
                                selected = "Falls (W00-W19)"))),
              fluidRow(
                box(title = "Year Options", width = 4,
                    radioButtons("app3_year", "Select Year", choices = c(levels(as.factor(cdc$year))),
                                 selected = "1999")),
                box(title = "Graph", width = 8,
                    plotOutput("app3", width = "800px", height = "500px")))
              ),
      
      tabItem(tabName= "app4",
              fluidRow(
                box(title = "Graph Options", width = 12,
                    selectInput("app4_death", "Select Cause of Death", choices = c(levels(cdc$cause_of_death)),
                                selected = "Falls (W00-W19)"))),
              fluidRow(
                box(width = 12,
                    plotOutput("app4", width = "800px", height = "500px")))
      )
      
    )))

server <- function(input, output, session) { 

  
  ## APP 1 OUTPUT PLOT
  output$app1 <- renderPlot({
    
    cdc %>% 
      filter(cause_of_death == input$app1_cause_of_death) %>% 
      
      group_by(year) %>% 
      summarise(
        population = sum(population, na.rm=T),
        #In the Data, N.S. age groups included in the population of all existing age groups. So it is OK to remove the NA values because it will product the same result.
        total_deaths = sum(deaths),
        percent= (total_deaths/population)*100
      ) %>% 
      ggplot(aes(x=year, y=total_deaths, group=1))+geom_area(fill="blue",color="grey", alpha=0.5)+labs(y="Total Deaths", x="Year")+ggtitle(paste(input$app1_cause_of_death, "Deaths by Year"))+
      scale_x_continuous(breaks = seq(1999, 2018, by = 1), limits=c(1999,2018))+
      theme(plot.title = element_text(size = 14, face = "bold", vjust = 3.5, hjust=.5, margin = margin(t=15, b=10)),
            axis.text = element_text(size = 12),
            axis.title = element_text(size = 12),
            axis.title.y = element_text(margin = margin(t = 0, r = 15, b = 0, l = 0)),
            axis.title.x = element_text(margin = margin(t = 10, r = 0, b = 0, l = 0)))})
  
  output$app1totalyr <- renderTable({
    cdc %>% 
      filter(cause_of_death == input$app1_cause_of_death) %>% 
      summarise(
        total_deaths = sum(deaths))})
  

  output$app1totalmf <- renderTable({
    cdc %>% 
      filter(cause_of_death == input$app1_cause_of_death) %>% 
      group_by(gender) %>% 
      summarise(
        total_deaths = sum(deaths))})
  
  output$app1total <- renderTable({
    cdc %>% 
      filter(cause_of_death == input$app1_cause_of_death) %>%
      group_by(year) %>% 
      summarise(
        total_deaths = sum(deaths),
        population = sum(population, na.rm=T),
        percent_us_pop= (total_deaths/population)*100
      )})
  
  
  output$app2 <- renderPlot({
    cdc %>% 
      group_by(age_group, gender, year) %>% 
      filter(year== input$app2_year) %>% 
      filter(age_group != "Not Stated") %>% 
      summarize(
        total_deaths = sum(deaths),
        total_population = sum(population),
        death_per_100k = total_deaths/total_population*100000,
        percent_of_group = total_deaths/total_population) %>% 
    
      ggplot(aes_string(x="age_group", y=input$app2_measure, fill="gender"))+geom_bar(position="dodge",stat="identity")+
      labs(
        title= "Deaths by Age Group",
        x= "Age Group",
        y= "Variable",
        color=NULL,
        fill=NULL)+
      theme(plot.title = element_text(size = 14, face = "bold", vjust = 3.5, hjust=.5, margin = margin(t=15, b=10)),
            axis.title.y = element_text(margin = margin(t = 0, r = 15, b = 0, l = 0)),
            axis.title.x = element_text(margin = margin(t = 10, r = 0, b = 0, l = 0)))
    
    
  })
  
  output$app3 <- renderPlot({
    cdc %>% 
      filter(cause_of_death ==input$app3_death & year == input$app3_year) %>% 
      group_by(race) %>%
      summarise(population = sum(population, na.rm = T),
                total_deaths = sum(deaths),
                per100k = (total_deaths/population)*100000) %>%
      ggplot(aes_string(x = "race", y = "per100k", fill = "race")) +
      geom_col(position = "dodge") +
      coord_flip()+
      labs(title="Deaths in The United States", y="Deaths per 100k", x="Race", color=NULL,fill=NULL)+
      theme(plot.title = element_text(size = 14, face = "bold", vjust = 3.5, hjust=.5, margin = margin(t=15, b=10)),
            axis.title.y = element_text(margin = margin(t = 0, r = 15, b = 0, l = 0)),
            axis.text.x = element_text(angle = 90, hjust=1),
            axis.title.x = element_text(margin = margin(t = 10, r = 0, b = 0, l = 0)))
  })
  
  output$app4 <- renderPlot({
    
    cdc %>% 
      filter(cause_of_death == input$app4_death) %>% 
      group_by(gender, year) %>%
      summarise(
        population = sum(population, na.rm=T),
        total_deaths = sum(deaths),
        percent= (total_deaths/population)*100
      ) %>%
      ggplot(aes(x = year, y =percent, color = gender)) +
      geom_point(aes(shape = gender, size = 3))+
      labs(title="Deaths in The United States by Gender", y="Percent of Population", x="Year")+
      theme(plot.title = element_text(size = 14, face = "bold", vjust = 3.5, hjust=.5, margin = margin(t=15, b=10)),
            axis.text = element_text(size = 12),
            axis.title = element_text(size = 12),
            axis.title.y = element_text(margin = margin(t = 0, r = 15, b = 0, l = 0)),
            axis.title.x = element_text(margin = margin(t = 10, r = 0, b = 0, l = 0)))})
  
  session$onSessionEnded(stopApp)
  
}

shinyApp(ui, server)