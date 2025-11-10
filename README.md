# Statehandler V0.1 Beta DOCUMENTATION
  ## What is a statehandler?
  a statehandler is a way to handle states for your player for example imagine you are making a fighting game, and you want the set a state for the player that its punching then you can set that and read it through other scripts EASILY.
  ## How to use this statehandler?
  ### Importing it.
  download the .rblx file from releases and import it into replicatedstorage
  ### Using it in your scripts
  Require the modulescript by typing
  ```lua
    local stateHandler=require(path to statehandler)
  ```
  ### SetState
  The SetState function is the main part of using this statehandler, and this is how it works,
  first type:
  ```lua
  stateHandler.SetState()
  ```
  this will run the function with no arguments, so it wont do much.
  the arguments are as followed: player, stateKey, value, duration

  and this will be the explanation of the arguments

  We will start with the player argument
    in the player argument you will have to give the plr (game:GetService("Players").plrname if you want a specific plr)

  Now the stateKey argument
    This will be the name of the state, and how other scripts would read the state.

  Now the Value argument
    this is what you would like to set the state to i would prefer doing a boolean like true but you can also input strings, numbers, tables, etc

  The duration argument
    this is an unneeded argument but if you set this argument it will set the duration for how long you would have that state and after that duration it would be deleted.

  
