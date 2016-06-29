# -*- coding: utf-8 -*-
# Generated by Django 1.9.2 on 2016-06-29 18:17
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('MoneyMonsterData', '0004_auto_20160624_2007'),
    ]

    operations = [
        migrations.RenameField(
            model_name='quizquestion',
            old_name='question_text',
            new_name='statement',
        ),
        migrations.RenameField(
            model_name='quizquestion',
            old_name='answer',
            new_name='statement_is_true',
        ),
        migrations.RemoveField(
            model_name='quiz',
            name='video',
        ),
        migrations.RemoveField(
            model_name='quizquestion',
            name='correct_message',
        ),
        migrations.RemoveField(
            model_name='quizquestion',
            name='false_message',
        ),
        migrations.AddField(
            model_name='quizquestion',
            name='statement_message',
            field=models.TextField(blank=True, max_length=1000),
        ),
        migrations.AddField(
            model_name='todo',
            name='completed',
            field=models.BooleanField(default=False),
        ),
        migrations.AddField(
            model_name='video',
            name='quiz',
            field=models.ForeignKey(blank=True, default=None, null=True, on_delete=django.db.models.deletion.CASCADE, to='MoneyMonsterData.Quiz'),
        ),
        migrations.AddField(
            model_name='video',
            name='sort_order',
            field=models.IntegerField(default=0),
        ),
        migrations.AddField(
            model_name='video',
            name='todo_icon',
            field=models.CharField(default='', max_length=255),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='video',
            name='todo_text',
            field=models.CharField(default='', max_length=255),
            preserve_default=False,
        ),
        migrations.AlterField(
            model_name='todo',
            name='date_completed',
            field=models.DateTimeField(blank=True, null=True),
        ),
        migrations.AlterUniqueTogether(
            name='quizresult',
            unique_together=set([('quiz', 'user')]),
        ),
    ]