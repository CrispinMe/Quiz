# Quiz
Big Nerd Ranch iOS Programming Chapter 8 Silver Challenge: Animating Constraints - Layout Guides

The scenario consists of a simple Quiz appliction. The app displays a question to the user. The user can reveal the answer to the question by clicking the "Show Answer Button". The user can view the next question by clicking the "Next Question" button.

The next question text is slided into view from the lefthand side of the screen by use of an animation. To achieve the animation for subsequent questions two UILabels are used: the next question label and the current question label.

The animation moves both labels a full screen width to the right.

The challenge consisted of preventing the next question label from becoming visible when not animating, when the device is rotated to landscape.

The solution utilises two UILayoutguides whose widths are set to equal the screen width. The first UILayoutGuide's centre anchor is constrained to the view's leading anchor and the second UILayoutGuide's leading anchor is constrained to the view's centre X anchor.

The nextQuestionLabel is held off screen when not animating by constraing it's centre X anchor to the second UILayoutGuide's trailing anchor.
