import 'package:flutter/material.dart';
import 'package:beanmind_flutter/configs/configs.dart';

enum AnswerStatus{
  correct, wrong, answered, notanswered
}

class AnswerCard extends StatelessWidget {
  const AnswerCard({
    super.key,
    required this.answer,
    this.isSelected = false, required this.onTap,
  });

  final String answer;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: UIParameters.cardBorderRadius,
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: UIParameters.cardBorderRadius,
            color: isSelected
                ? answerSelectedColor(context)
                : Theme.of(context).cardColor,
            border: Border.all(
                color: isSelected
                    ? answerSelectedColor(context)
                    : answerBorderColor(context))),
        child: Center(
          child: Text(
            answer,
            style: TextStyle(
              color: isSelected ? kOnSurfaceTextColor : null,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}


class CorrectAnswerCard extends StatelessWidget {
  const CorrectAnswerCard({
    super.key,
    required this.answer,
  });

  final String answer;

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: UIParameters.cardBorderRadius,
        color: kCorrectAnswerColor.withOpacity(0.1),
      ),
      child: Center(
        child: Text(
          answer,
          style: const TextStyle(
            color: kCorrectAnswerColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class WrongAnswerCard extends StatelessWidget {
  const WrongAnswerCard({
    super.key,
    required this.answer,
  });

  final String answer;

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: UIParameters.cardBorderRadius,
        color: kWrongAnswerColor.withOpacity(0.1),
      ),
      child: Center(
        child: Text(
          answer,
          style: const TextStyle(
            color: kWrongAnswerColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class NotAnswerCard extends StatelessWidget {
  const NotAnswerCard({
    super.key,
    required this.answer,
  });

  final String answer;

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: UIParameters.cardBorderRadius,
        color: kNotAnswerColor.withOpacity(0.1),
      ),
      child: Center(
        child: Text(
          answer,
          style: const TextStyle(
            color: kNotAnswerColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}


