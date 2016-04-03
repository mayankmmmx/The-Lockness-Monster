//Set the motors to respective pins
motor1Ground <- hardware.pin8;
motor1Positive <- hardware.pin9;
motor2Ground <- hardware.pin5;
motor2Positive <- hardware.pin7;

//Configure original motor state
motor1Ground.configure(DIGITAL_OUT, 0);
motor1Positive.configure(DIGITAL_OUT, 0);
motor2Ground.configure(DIGITAL_OUT, 0);
motor2Positive.configure(DIGITAL_OUT, 0);
 
//Sets motor 1 state
//1 = forward; 0 = stationary; -1 = reverse
function setMotor1State(state)
{
    server.log("Setting motor 1 to state: " + state);
    if(state == 1)
    {
        motor1Ground.write(1);
        motor1Positive.write(0);
    }
    else if(state == -1)
    {
        motor1Ground.write(0);
        motor1Positive.write(1);   
    }
    else
    {
        motor1Ground.write(0);
        motor1Positive.write(0);
    }
}

//Sets motor 2 state
//1 = forward; 0 = stationary; -1 = reverse
function setMotor2State(state)
{
    server.log("Setting motor 2 to state: " + state);
    if(state == 1)
    {
        motor2Ground.write(1);
        motor2Positive.write(0);
    }
    else if(state == -1)
    {
        motor2Ground.write(0);
        motor2Positive.write(1);   
    }
    else
    {
        motor2Ground.write(0);
        motor2Positive.write(0);
    }
}

// Register a handler for incoming "set.motor1" messages from the agent
agent.on("set.motor1", setMotor1State);

// Register a handler for incoming "set.motor2" messages from the agent
agent.on("set.motor2", setMotor2State);

agent.send("location", imp.scanwifinetworks());