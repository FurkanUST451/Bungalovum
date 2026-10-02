import 'package:flutter/widgets.dart';

import '../../domain/listing_draft.dart';
import 'wizard_steps_a.dart';
import 'wizard_steps_b.dart';
import 'wizard_steps_c.dart';

/// Adımın ekranı; [editing] ise İlan Yönetimi'nden düzenleme modunda.
Widget wizardStepScreen(WizardStep step, {bool editing = false}) =>
    switch (step) {
      WizardStep.typeAndLocation => TypeLocationStep(editing: editing),
      WizardStep.basics => BasicsStep(editing: editing),
      WizardStep.poolAndAmenities => PoolAmenitiesStep(editing: editing),
      WizardStep.photos => PhotosStep(editing: editing),
      WizardStep.titleAndDescription => TitleDescriptionStep(editing: editing),
      WizardStep.safetyAndRules => SafetyRulesStep(editing: editing),
      WizardStep.pricing => PricingStep(editing: editing),
      WizardStep.checkIn => CheckInStep(editing: editing),
      WizardStep.legal => LegalStep(editing: editing),
      WizardStep.identityAndPayout => IdentityPayoutStep(editing: editing),
    };
