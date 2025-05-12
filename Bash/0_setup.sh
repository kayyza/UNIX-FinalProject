#application to mirror the website / run the container

user_name=$(whoami) #checks who is the current user and puts in a variable

echo "Hi $user_name!"
echo "You seem to want to host your own website! Let's get started!"

read -p "If you want to mirror a static github page website, enter 1. If you want to host a node-based website, enter 2 : " user_ans

if [ $user_ans = 1 ]

elif [ $user_ans = 2 ]

else
    echo "invalid answer... Exiting hosting wizard :( "
    exit 1
fi